import 'package:parkflow/models/parking/parking_slot_model.dart';

abstract class ParkingRepositoryInterface {
  Future<List<ParkingSlotModel>> getParkingSlots();
  Stream<List<ParkingSlotModel>> watchParkingSlots();
}
