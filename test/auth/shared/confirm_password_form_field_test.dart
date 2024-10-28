import 'package:auth_boilerplate/auth/shared/confirm_password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Confirm Password Form Field should', () {
    late TextEditingController passwordController;
    late TextEditingController confirmPasswordController;
    const key = Key('confirm_password_form_field');

    setUp(() {
      passwordController = TextEditingController();
      confirmPasswordController = TextEditingController();
    });

    tearDown(() {
      passwordController.dispose();
      confirmPasswordController.dispose();
    });

    testWidgets('show error message if confirm password is empty', (tester) async {
      // Given
      await tester.pumpFormWidget(ConfirmPasswordFormField(confirmPasswordController, passwordController));

      // When
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Field is required');
    });

    testWidgets('show error message if confirm password does not match password', (tester) async {
      // Given
      passwordController.text = "text";
      await tester.pumpFormWidget(ConfirmPasswordFormField(confirmPasswordController, passwordController));

      // When
      await tester.enterText(find.byKey(key), 'tes');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, "Passwords don't match");
    });

    testWidgets('show no error message if passwords match', (tester) async {
      // Given
      passwordController.text = "text";
      await tester.pumpFormWidget(ConfirmPasswordFormField(confirmPasswordController, passwordController));

      // When
      await tester.enterText(find.byKey(key), 'text');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, null);
    });
  });
}
