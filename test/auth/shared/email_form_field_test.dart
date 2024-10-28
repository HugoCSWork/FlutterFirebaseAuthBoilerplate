import 'package:auth_boilerplate/auth/shared/email_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Email Form Field should', () {
    late TextEditingController controller;
    const key = Key('email_form_field');

    setUp(() => controller = TextEditingController());

    tearDown(() => controller.dispose());

    testWidgets('show error message if email is empty', (tester) async {
      // Given
      await tester.pumpFormWidget(EmailFormField(controller));

      // When
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Field is required');
    });

    testWidgets('show error message if email is not valid', (tester) async {
      // Given
      await tester.pumpFormWidget(EmailFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'invalid email');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Please enter a valid email');
    });

    testWidgets('show no error message if email is valid', (tester) async {
      // Given
      await tester.pumpFormWidget(EmailFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'test@test.com');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, null);
    });
  });
}
