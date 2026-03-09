import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/presentation/widgets/common/app_buttons.dart';

void main() {
  group('AppPrimaryButton', () {
    testWidgets('should display label and respond to tap', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPrimaryButton(
              label: 'Click Me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);

      await tester.tap(find.text('Click Me'));
      expect(pressed, isTrue);
    });

    testWidgets(
      'should show loading indicator and be disabled when isLoading is true',
      (tester) async {
        bool pressed = false;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppPrimaryButton(
                label: 'Click Me',
                onPressed: () => pressed = true,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        // label is hidden during loading in AppPrimaryButton
        expect(find.text('Click Me'), findsNothing);

        await tester.tap(find.byType(AppPrimaryButton));
        expect(pressed, isFalse);
      },
    );

    testWidgets('should be disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPrimaryButton(label: 'Disabled', onPressed: null),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);
    });
  });
}
