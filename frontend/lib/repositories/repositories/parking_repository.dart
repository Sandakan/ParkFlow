import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:parkflow/repositories/interfaces/parking_repository_interface.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:parkflow/utils/helpers/talker.dart';

class ParkingRepository implements ParkingRepositoryInterface {
  final RemoteRepositoryInterface _remote;
  final String _baseUrl;
  socket_io.Socket? _socket;

  ParkingRepository(this._remote, this._baseUrl);

  @override
  Future<List<ParkingSlotModel>> getParkingSlots() async {
    try {
      final response = await _remote.getParkingSlots();
      return response.slots;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Stream<List<ParkingSlotModel>> watchParkingSlots() {
    final controller = StreamController<List<ParkingSlotModel>>.broadcast();

    getParkingSlots()
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
