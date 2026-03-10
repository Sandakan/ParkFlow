import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/entities/reservation/create_reservation_request_entity.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';
import 'package:parkflow/core/network/entities/reservation_response_entity.dart';
import 'package:parkflow/core/network/entities/slot_availability_response_entity.dart';

part 'reservation_service.g.dart';

class ReservationService {
  final RemoteRepositoryInterface _remoteRepository;
  final String _baseUrl;
  final Ref _ref;

  ReservationService(this._remoteRepository, this._baseUrl, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<List<ReservationModel>> getMyReservations() async {
    return _remoteRepository.getMyReservations(accessToken: await _getToken());
  }

  Future<ReservationResponseEntity> createReservation({
    required String slotId,
    String? lotId,
    required VehicleModel vehicle,
    required DateTime startTime,
    required int durationMinutes,
    required String paymentMethod,
  }) async {
    talker.debug(
      'ReservationService: Creating reservation with local startTime: $startTime',
    );
    talker.debug('ReservationService: startTime.toUtc(): ${startTime.toUtc()}');
    talker.debug(
      'ReservationService: startTime.toUtc().toIso8601String(): ${startTime.toUtc().toIso8601String()}',
    );

    final request = CreateReservationRequestEntity(
      slotId: slotId,
      lotId: lotId,
      vehicle: vehicle,
      startTime: startTime.toUtc().toIso8601String(),
      durationMinutes: durationMinutes,
      paymentMethod: paymentMethod,
    );

    return _remoteRepository.createReservation(
      request,
      accessToken: await _getToken(),
    );
  }

  Future<SlotAvailabilityResponseEntity> checkSlotAvailability({
    required String slotId,
    required DateTime startTime,
    required int durationMinutes,
  }) async {
    return _remoteRepository.checkSlotAvailability(
      slotId,
      startTime: startTime,
      durationMinutes: durationMinutes,
      accessToken: await _getToken(),
    );
  }

  Future<SlotAvailabilityResponseEntity> checkLotAvailability({
    required String lotId,
    required DateTime startTime,
    required int durationMinutes,
  }) async {
    return _remoteRepository.checkLotAvailability(
      lotId,
      startTime: startTime,
      durationMinutes: durationMinutes,
      accessToken: await _getToken(),
    );
  }

  Future<ReservationResponseEntity> scanReservationQr(
    String token, {
    bool confirm = false,
    String? paymentMethod,
  }) async {
    return _remoteRepository.scanReservationQr(
      token,
      confirm: confirm,
      paymentMethod: paymentMethod,
      accessToken: await _getToken(),
    );
  }

  Stream<List<ReservationModel>> streamMyReservations() {
    final controller = StreamController<List<ReservationModel>>.broadcast();
    http.Client? client;
    bool isCancelled = false;

    Future<void> connect() async {
      if (isCancelled || controller.isClosed) return;

      client?.close();
      client = http.Client();

      try {
        final token = await _getToken();
        final url = Uri.parse('$_baseUrl/reservations/stream');

        final request = http.Request('GET', url);
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        request.headers['Accept'] = 'text/event-stream';
        request.headers['Cache-Control'] = 'no-cache';

        final response = await client!.send(request);

        if (response.statusCode != 200) {
          talker.error(
            'Reservation SSE: Failed to connect stream: ${response.statusCode}',
          );
          await Future.delayed(const Duration(seconds: 3));
          return connect();
        }

        await for (final line
            in response.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())) {
          if (isCancelled || controller.isClosed) break;

          if (line.startsWith('data: ')) {
            try {
              final jsonStr = line.substring(6);
              final List data = json.decode(jsonStr) as List;
              final reservations = data
                  .map((e) => ReservationModel.fromJson(e))
                  .toList();
              if (!controller.isClosed) {
                controller.add(reservations);
              }
            } catch (e) {
              talker.error('Reservation SSE: Error parsing data', e);
            }
          }
        }
      } catch (e) {
        talker.error('Reservation SSE: Stream error: $e');
      } finally {
        if (!isCancelled && !controller.isClosed) {
          talker.info('Reservation SSE: Disconnected, retrying in 3s...');
          await Future.delayed(const Duration(seconds: 3));
          await connect();
        }
      }
    }

    connect();

    controller.onCancel = () {
      isCancelled = true;
      client?.close();
      talker.info('Reservation SSE: stream cancelled');
    };

    return controller.stream;
  }

  Future<void> rateReservation(
    String reservationId,
    double rating, {
    String? comment,
  }) async {
    return _remoteRepository.rateReservation(
      reservationId,
      rating,
      comment: comment,
      accessToken: await _getToken(),
    );
  }
}

@riverpod
ReservationService reservationService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final env = ref.watch(envRepositoryProvider);
  return ReservationService(remote, env.getBaseUrl(), ref);
}
