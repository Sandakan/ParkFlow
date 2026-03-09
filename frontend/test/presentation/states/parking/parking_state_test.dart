import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';

void main() {
  group('ParkingState', () {
    test('initial state should have defaults', () {
      const state = ParkingState();
      expect(state.isLoading, isTrue);
      expect(state.slots, isEmpty);
      expect(state.lots, isEmpty);
      expect(state.error, isNull);
    });

    test('copyWith should update fields', () {
      const state = ParkingState();
      final newState = state.copyWith(
        isLoading: false,
        lots: [
          const ParkingLotModel(
            id: '1',
            name: 'Lot 1',
            address: 'Addr',
            latitude: 0,
            longitude: 0,
            totalSlots: 10,
            occupancy: 0.5,
            isOpen: true,
            camerasCount: 2,
            revenueToday: 500,
          )
        ],
        error: const AppException(AppStatusCode.networkError),
      );

      expect(newState.isLoading, isFalse);
      expect(newState.lots.length, 1);
      expect(newState.error?.code, AppStatusCode.networkError);
    });
  });
}
