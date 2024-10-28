import 'package:auth_boilerplate/auth/reset_password/reset_password_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Reset Password Form should', () {
    test('return list of controllers when controllers getter is called', () {
      // Given
      final form = ResetPasswordForm();

      // When
      final controllers = form.controllers;

      // Then
      expect(controllers.length, 1);
      expect(controllers[0], form.emailController);
    });

    test('get email when email getter is called', () {
      // Given
      final form = ResetPasswordForm();
      const emailText = "Test";
      form.emailController.text = emailText;

      // When
      final email = form.email;

      // Then
      expect(email, emailText);
    });
  });
}
