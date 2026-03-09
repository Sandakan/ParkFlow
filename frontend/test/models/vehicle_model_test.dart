import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';

void main() {
  group('VehicleModel', () {
    test('should parse from JSON correctly', () {
      final json = {
        'plate_number': 'ABC-1234',
        'type': 'car',
      };

      final vehicle = VehicleModel.fromJson(json);

      expect(vehicle.plateNumber, 'ABC-1234');
      expect(vehicle.type, 'car');
    });

    test('should convert to JSON correctly', () {
      const vehicle = VehicleModel(
        plateNumber: 'XYZ-5678',
        type: 'van',
      );

      final json = vehicle.toJson();

      expect(json['plate_number'], 'XYZ-5678');
      expect(json['type'], 'van');
    });

    test('equality should work correctly', () {
      const vehicle1 = VehicleModel(plateNumber: 'A', type: 'B');
      const vehicle2 = VehicleModel(plateNumber: 'A', type: 'B');
      const vehicle3 = VehicleModel(plateNumber: 'C', type: 'D');

      expect(vehicle1, equals(vehicle2));
      expect(vehicle1, isNot(equals(vehicle3)));
    });
  });
}
