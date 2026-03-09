import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/parking/camera_model.dart';

void main() {
  group('CameraModel', () {
    test('should parse from JSON correctly', () {
      final json = {
        'id': 'cam_1',
        'name': 'Main Entrance',
        'rtspUrl': 'rtsp://example.com/stream',
        'lotId': 'lot_123',
        'isAlive': true,
        'lotName': 'Central Mall',
      };

      final camera = CameraModel.fromJson(json);

      expect(camera.id, 'cam_1');
      expect(camera.name, 'Main Entrance');
      expect(camera.rtspUrl, 'rtsp://example.com/stream');
      expect(camera.lotId, 'lot_123');
      expect(camera.isAlive, isTrue);
      expect(camera.lotName, 'Central Mall');
    });

    test('should use default values for missing optional fields', () {
      final json = {
        'id': 'cam_2',
        'name': 'Exit',
        'rtspUrl': 'rtsp://example.com/exit',
        'lotId': 'lot_456',
      };

      final camera = CameraModel.fromJson(json);

      expect(camera.isAlive, isTrue);
      expect(camera.lotName, isNull);
    });

    test('equality should work correctly', () {
      const camera1 = CameraModel(id: '1', name: 'A', rtspUrl: 'U', lotId: 'L');
      const camera2 = CameraModel(id: '1', name: 'A', rtspUrl: 'U', lotId: 'L');

      expect(camera1, equals(camera2));
    });
  });
}
