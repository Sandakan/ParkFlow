import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/repositories/entities/parking/point2d.dart';

void main() {
  group('ParkingSlotModel', () {
    test('should parse from JSON correctly', () {
      final json = {
        'id': 'slot_1',
        'name': 'A-01',
        'isOccupied': false,
        'status': 'vacant',
        'lot_id': 'lot_123',
        'slot_type': 'car',
        'camera_id': 'cam_1',
        'logical_row': 1,
        'logical_col': 2,
        'coordinates': [
          {'x': 0.1, 'y': 0.2},
          {'x': 0.3, 'y': 0.4}
        ],
        'lastUpdated': '2026-03-09T10:00:00Z',
      };

      final slot = ParkingSlotModel.fromJson(json);

      expect(slot.id, 'slot_1');
      expect(slot.name, 'A-01');
      expect(slot.isOccupied, isFalse);
      expect(slot.status, 'vacant');
      expect(slot.lotId, 'lot_123');
      expect(slot.slotType, 'car');
      expect(slot.logicalRow, 1);
      expect(slot.logicalCol, 2);
      expect(slot.coordinates?.length, 2);
      expect(slot.coordinates?[0].x, 0.1);
      expect(slot.lastUpdated, isNotNull);
    });

    test('should use defaults for missing fields', () {
      final json = {
        'id': 'slot_2',
        'name': 'B-02',
        'isOccupied': true,
      };

      final slot = ParkingSlotModel.fromJson(json);

      expect(slot.status, 'vacant');
      expect(slot.logicalRow, 0);
      expect(slot.logicalCol, 0);
    });

    test('equality should work correctly', () {
      const slot1 = ParkingSlotModel(id: '1', name: 'N', isOccupied: false);
      const slot2 = ParkingSlotModel(id: '1', name: 'N', isOccupied: false);
      
      expect(slot1, equals(slot2));
    });
  });

  group('Point2D', () {
    test('should parse from JSON correctly', () {
      final json = {'x': 10.0, 'y': 20.0};
      final point = Point2D.fromJson(json);
      expect(point.x, 10.0);
      expect(point.y, 20.0);
    });
  });
}
