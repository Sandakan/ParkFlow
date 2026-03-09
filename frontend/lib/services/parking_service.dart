import 'dart:async';
import 'dart:convert';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/core/network/entities/get_parking_lot_response_entity.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';
import 'package:parkflow/core/network/entities/get_parking_suggestions_response_entity.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';

part 'parking_service.g.dart';

class ParkingService {
  final RemoteRepositoryInterface _remote;
  final String _baseUrl;
  final Ref _ref;
  ParkingService(this._remote, this._baseUrl, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<List<ParkingSlotModel>> fetchParkingSlots({
    String? cameraId,
    String? lotId,
  }) async {
    try {
      final response = await _remote.getParkingSlots(
        cameraId: cameraId,
        lotId: lotId,
        accessToken: await _getToken(),
      );
      return response.slots;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> createParkingSlot(CreateParkingSlotRequest request) async {
    try {
      await _remote.createParkingSlot(request, accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> deleteParkingSlot(String slotId, {String? cameraId}) async {
    try {
      await _remote.deleteParkingSlot(
        slotId,
        cameraId: cameraId,
        accessToken: await _getToken(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<ParkingLotModel>> fetchParkingLots({
    String? search,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final response = await _remote.getParkingLots(
        search: search,
        latitude: latitude,
        longitude: longitude,
        accessToken: await _getToken(),
      );
      return response.lots;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> createParkingLot(CreateParkingLotRequest request) async {
    try {
      await _remote.createParkingLot(request, accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetParkingLotResponseEntity> fetchParkingLot(String lotId) async {
    try {
      return await _remote.getParkingLot(lotId, accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> updateParkingLot(
    String lotId,
    UpdateParkingLotRequest request,
  ) async {
    try {
      await _remote.updateParkingLot(
        lotId,
        request,
        accessToken: await _getToken(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> deleteParkingLot(String lotId) async {
    try {
      await _remote.deleteParkingLot(lotId, accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetParkingSuggestionsResponseEntity> getParkingSuggestions(
    String lotId,
  ) async {
    try {
      return await _remote.getParkingSuggestions(
        lotId,
        accessToken: await _getToken(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Stream<List<ParkingSlotModel>> streamParkingSlots({String? lotId}) {
    final controller = StreamController<List<ParkingSlotModel>>.broadcast();
    http.Client? client;
    bool isCancelled = false;

    Future<void> connect() async {
      if (isCancelled || controller.isClosed) return;

      client?.close();
      client = http.Client();

      try {
        final token = await _getToken();
        final url = Uri.parse(
          '$_baseUrl/parking/stream${lotId != null ? '?lot_id=$lotId' : ''}',
        );

        final request = http.Request('GET', url);
        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        request.headers['Accept'] = 'text/event-stream';
        request.headers['Cache-Control'] = 'no-cache';

        final response = await client!.send(request);

        if (response.statusCode != 200) {
          talker.error('Failed to connect to stream: ${response.statusCode}');
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
              final List slotsData = json.decode(jsonStr) as List;
              final slots = slotsData
                  .map((e) => ParkingSlotModel.fromJson(e))
                  .toList();
              if (!controller.isClosed) {
                controller.add(slots);
              }
            } catch (e) {
              talker.error('Error parsing SSE data', e);
            }
          }
        }
      } catch (e) {
        talker.error('SSE Stream error: $e');
      } finally {
        if (!isCancelled && !controller.isClosed) {
          talker.info('SSE Stream disconnected, retrying in 3s...');
          await Future.delayed(const Duration(seconds: 3));
          await connect();
        }
      }
    }

    connect();

    controller.onCancel = () {
      isCancelled = true;
      client?.close();
      talker.info('Parking slots stream cancelled, client closed');
    };

    return controller.stream;
  }
}

@Riverpod(keepAlive: true)
ParkingService parkingService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final env = ref.watch(envRepositoryProvider);
  return ParkingService(remote, env.getBaseUrl(), ref);
}
