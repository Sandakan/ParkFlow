import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_card.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockParkingNotifier mockParkingNotifier;

  setUp(() {
    mockParkingNotifier = MockParkingNotifier();

    registerFallbackValue(
      const ParkingLotModel(
        id: '0',
        name: '',
        isOpen: true,
        camerasCount: 0,
        totalSlots: 0,
        occupancy: 0,
        revenueToday: 0,
        address: '',
        latitude: 0,
        longitude: 0,
      ),
    );

    when(
      () => mockParkingNotifier.selectLot(any()),
    ).thenAnswer((_) async => {});
  });

  const testLot = ParkingLotModel(
    id: 'lot_1',
    name: 'Test Parking',
    address: '123 Test St',
    latitude: 6.9,
    longitude: 79.8,
    totalSlots: 50,
    occupancy: 0.2, // 10 slots occupied, 40 available
    isOpen: true,
    camerasCount: 2,
    revenueToday: 1500,
    distanceMeters: 500,
  );

  testWidgets('ParkingLotCard should render correctly and respond to tap', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [parkingProvider.overrideWith(() => mockParkingNotifier)],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) {
                ref.watch(parkingProvider);
                return ParkingLotCard(lot: testLot, isSelected: false);
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Parking'), findsOneWidget);
    expect(find.text('123 Test St'), findsOneWidget);
    expect(find.text('Open'), findsOneWidget);
    expect(find.textContaining('40'), findsOneWidget);
    expect(find.textContaining('500'), findsOneWidget);

    await tester.tap(find.text('Test Parking'));
    await tester.pumpAndSettle();

    verify(() => mockParkingNotifier.selectLot(any())).called(1);
  });
}
