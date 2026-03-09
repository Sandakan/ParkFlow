import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';
import 'package:parkflow/presentation/widgets/forms/custom_reactive_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Form Field Widgets', () {
    testWidgets(
      'LabeledReactiveTextField should render label and respond to input',
      (tester) async {
        final form = FormGroup({'name': FormControl<String>(value: '')});

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReactiveForm(
                formGroup: form,
                child: const LabeledReactiveTextField(
                  label: 'Your Name',
                  formControlName: 'name',
                  isRequired: true,
                ),
              ),
            ),
          ),
        );

        expect(
          find.byWidgetPredicate(
            (w) => w is RichText && w.text.toPlainText().contains('Your Name'),
          ),
          findsOneWidget,
        );
        expect(
          find.byWidgetPredicate(
            (w) => w is RichText && w.text.toPlainText().contains(' *'),
          ),
          findsOneWidget,
        );

        await tester.enterText(find.byType(TextField), 'John Doe');
        expect(form.control('name').value, 'John Doe');
      },
    );

    testWidgets('LabeledReactiveDropdownField should render label and items', (
      tester,
    ) async {
      final form = FormGroup({'type': FormControl<String>(value: 'car')});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: LabeledReactiveDropdownField<String>(
                label: 'Vehicle Type',
                formControlName: 'type',
                items: const [
                  DropdownMenuItem(value: 'car', child: Text('Car')),
                  DropdownMenuItem(value: 'van', child: Text('Van')),
                ],
              ),
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (w) => w is RichText && w.text.toPlainText().contains('Vehicle Type'),
        ),
        findsOneWidget,
      );
      expect(find.text('Car'), findsWidgets);

      await tester.tap(find.text('Car').first);
      await tester.pumpAndSettle();

      expect(find.text('Van'), findsOneWidget);
      await tester.tap(find.text('Van'));
      await tester.pumpAndSettle();

      expect(form.control('type').value, 'van');
    });

    testWidgets(
      'CustomReactiveTextField should render labelText and obscureText',
      (tester) async {
        final form = FormGroup({'password': FormControl<String>(value: '')});

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReactiveForm(
                formGroup: form,
                child: const CustomReactiveTextField(
                  formControlName: 'password',
                  labelText: 'Password',
                  obscureText: true,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Password'), findsOneWidget);
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.obscureText, isTrue);
      },
    );
  });
}
