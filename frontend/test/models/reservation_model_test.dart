import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/parking/reservation_model.dart';

void main() {
  group('ReservationModel', () {
    final startTime = DateTime.parse('2026-03-09T10:00:00Z');
    final endTime = DateTime.parse('2026-03-09T11:00:00Z');
    final createdAt = DateTime.parse('2026-03-09T09:00:00Z');

    final json = {
      'id': 'res_1',
      'user_id': 'user_123',
      'slot_id': 'slot_456',
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'vehicle': {'plate_number': 'ABC-1234', 'type': 'car'},
      'duration_minutes': 60,
      'payment_method': 'card',
      'total_price': 500.0,
      'base_rate': 10.0,
      'actual_end_time': endTime.toIso8601String(),
      'total_billed_price': 550.0,
      'status': 'ongoing',
      'qr_code_token': 'secret_token',
      'lot_name': 'Central Mall',
      'lot_address': '123 Main St',
      'lot_latitude': 6.9,
      'lot_longitude': 79.8,
      'slot_name': 'A-01',
      'created_at': createdAt.toIso8601String(),
      'updated_at': createdAt.toIso8601String(),
    };

    test('should parse from JSON correctly', () {
      final reservation = ReservationModel.fromJson(json);

      expect(reservation.id, 'res_1');
      expect(reservation.userId, 'user_123');
      expect(reservation.slotId, 'slot_456');
      expect(reservation.vehicle.plateNumber, 'ABC-1234');
      expect(reservation.totalPrice, 500.0);
      expect(reservation.status, 'ongoing');
    });

    test('detailedStatus extension should return correct status', () {
      final now = DateTime.now().toUtc();

      // Completed status
      final completedRes = ReservationModel.fromJson(
        json,
      ).copyWith(status: 'completed');
      expect(completedRes.detailedStatus, ReservationStatus.completed);

      // Cancelled status
      final cancelledRes = ReservationModel.fromJson(
        json,
      ).copyWith(status: 'cancelled');
      expect(cancelledRes.detailedStatus, ReservationStatus.cancelled);

      // Upcoming status
      final upcomingRes = ReservationModel.fromJson(json).copyWith(
        status: 'active',
        startTime: now.add(const Duration(hours: 1)),
        endTime: now.add(const Duration(hours: 2)),
      );
      expect(upcomingRes.detailedStatus, ReservationStatus.upcoming);

      // Ongoing status
      final ongoingRes = ReservationModel.fromJson(json).copyWith(
        status: 'active',
        startTime: now.subtract(const Duration(minutes: 30)),
        endTime: now.add(const Duration(minutes: 30)),
        checkInTime: now.subtract(const Duration(minutes: 20)),
      );
      expect(ongoingRes.detailedStatus, ReservationStatus.ongoing);

      // Overstay status
      final overstayRes = ReservationModel.fromJson(json).copyWith(
        status: 'active',
        startTime: now.subtract(const Duration(hours: 2)),
        endTime: now.subtract(const Duration(hours: 1)),
        checkInTime: now.subtract(const Duration(hours: 2)),
      );
      expect(overstayRes.detailedStatus, ReservationStatus.overstay);
    });
  });
}
