import 'package:auth_boilerplate/app/extensions/form_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Form Extensions isFormValid should', () {
    testWidgets('return true when form is valid', (tester) async {
      // Given
      final formKey = GlobalKey<FormState>();

      // When
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) return 'Cannot be empty';
                return null;
              },
            ),
          ),
        ),
      ));
      await tester.enterText(find.byType(TextFormField), 'Valid Input');
      formKey.currentState?.validate();

      // Then
      expect(formKey.isFormValid, true);
    });

    testWidgets('return false when form is not valid', (tester) async {
      // Given
      final formKey = GlobalKey<FormState>();

      // When
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) return 'Cannot be empty';
                return null;
              },
            ),
          ),
        ),
      ));
      formKey.currentState?.validate();

      // Then
      expect(formKey.isFormValid, false);
    });

    test('isFormValid returns false when form is null', () {
      // Given
      final formKey = GlobalKey<FormState>();

      // When Then
      expect(formKey.isFormValid, isFalse);
    });
  });
}
