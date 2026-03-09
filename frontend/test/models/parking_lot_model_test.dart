import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

void main() {
  group('ParkingLotModel', () {
    test('should parse from JSON correctly', () {
      final json = {
        'id': 'lot_1',
        'name': 'Main Parking',
        'isOpen': true,
        'camerasCount': 2,
        'totalSlots': 50,
        'occupancy': 0.5,
        'revenueToday': 1000,
        'address': '123 Street',
        'latitude': 6.9,
        'longitude': 79.8,
      };

      final lot = ParkingLotModel.fromJson(json);

      expect(lot.id, 'lot_1');
      expect(lot.name, 'Main Parking');
      expect(lot.isOpen, isTrue);
      expect(lot.totalSlots, 50);
      expect(lot.latitude, 6.9);
    });

    test('should support equality', () {
      const lot1 = ParkingLotModel(
        id: '1',
        name: 'A',
        isOpen: true,
        camerasCount: 0,
        totalSlots: 10,
        occupancy: 0,
        revenueToday: 0,
        address: 'Addr',
        latitude: 0,
        longitude: 0,
      );
      const lot2 = ParkingLotModel(
        id: '1',
        name: 'A',
        isOpen: true,
        camerasCount: 0,
        totalSlots: 10,
        occupancy: 0,
        revenueToday: 0,
        address: 'Addr',
        latitude: 0,
        longitude: 0,
      );

      expect(lot1, lot2);
    });
  });
}
