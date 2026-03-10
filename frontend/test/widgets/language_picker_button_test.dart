// ignore_for_file: invalid_use_of_visible_for_overriding_member
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/widgets/language_picker_button.dart';
import 'package:parkflow/presentation/providers/locale_provider.dart';
import 'package:mocktail/mocktail.dart';
import '../helpers/test_helpers.dart';

void main() {
  late MockAppLocale mockLocaleNotifier;

  setUp(() {
    mockLocaleNotifier = MockAppLocale();
    registerFallbackValue(const Locale('en'));
    when(() => mockLocaleNotifier.build()).thenReturn(const Locale('en'));
    when(() => mockLocaleNotifier.setLocale(any())).thenAnswer((_) async => {});
  });

  testWidgets(
    'LanguagePickerButton should show current language and allow selection',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appLocaleProvider.overrideWith(() => mockLocaleNotifier)],
          child: const MaterialApp(
            home: Scaffold(body: LanguagePickerButton()),
          ),
        ),
      );

      expect(find.text('EN'), findsWidgets);

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      expect(find.text('English'), findsOneWidget);
      expect(find.text('සිංහල'), findsOneWidget);
      expect(find.text('தமிழ்'), findsOneWidget);

      await tester.tap(find.text('සිංහල'));
      await tester.pumpAndSettle();

      verify(() => mockLocaleNotifier.setLocale(const Locale('si'))).called(1);
    },
  );
}
