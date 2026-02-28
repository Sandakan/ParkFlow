import 'dart:async';
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
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_slot_request.dart';

part 'parking_service.g.dart';

class ParkingService {
  final RemoteRepositoryInterface _remote;
  final String _baseUrl;
  socket_io.Socket? _socket;

  ParkingService(this._remote, this._baseUrl);

  Future<List<ParkingSlotModel>> fetchParkingSlots({String? cameraId}) async {
    try {
      final response = await _remote.getParkingSlots(cameraId: cameraId);
      return response.slots;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> createParkingSlot(CreateParkingSlotRequest request) async {
    try {
      await _remote.createParkingSlot(request);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> deleteParkingSlot(String slotId, {String? cameraId}) async {
    try {
      await _remote.deleteParkingSlot(slotId, cameraId: cameraId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<List<ParkingLotModel>> fetchParkingLots({String? search}) async {
    try {
      final response = await _remote.getParkingLots(search: search);
      return response.lots;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> createParkingLot(CreateParkingLotRequest request) async {
    try {
      await _remote.createParkingLot(request);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetParkingLotResponseEntity> fetchParkingLot(String lotId) async {
    try {
      return await _remote.getParkingLot(lotId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> updateParkingLot(
    String lotId,
    UpdateParkingLotRequest request,
  ) async {
    try {
      await _remote.updateParkingLot(lotId, request);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> deleteParkingLot(String lotId) async {
    try {
      await _remote.deleteParkingLot(lotId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Stream<List<ParkingSlotModel>> streamParkingSlots() {
    final controller = StreamController<List<ParkingSlotModel>>.broadcast();

    // Initial fetch
    fetchParkingSlots()
        .then((slots) {
          if (!controller.isClosed) {
            controller.add(slots);
          }
        })
        .catchError((e) {
          if (!controller.isClosed) controller.addError(e);
        });

    _socket = socket_io.io(
      _baseUrl,
      socket_io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket?.onConnect((_) {
      talker.info('Socket.IO connected for parking slots updates');
    });

    _socket?.on('slots_update', (data) {
      try {
        final List slotsData = data as List;
        final slots = slotsData
            .map((e) => ParkingSlotModel.fromJson(e))
            .toList();
        if (!controller.isClosed) {
          controller.add(slots);
        }
      } catch (e) {
        talker.error('Error parsing slot updates', e);
      }
    });

    _socket?.connect();

    controller.onCancel = () {
      _socket?.disconnect();
      _socket?.dispose();
    };

    return controller.stream;
  }
}

@riverpod
ParkingService parkingService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final env = ref.watch(envRepositoryProvider);
  return ParkingService(remote, env.getWebSocketUrl());
}
