import 'package:auth_boilerplate/auth/login/login_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login Form should', () {
    test('return list of controllers when controllers getter is called', () {
      // Given
      final form = LoginForm();

      // When
      final controllers = form.controllers;

      // Then
      expect(controllers.length, 2);
      expect(controllers[0], form.emailController);
      expect(controllers[1], form.passwordController);
    });

    test('get email when email getter is called', () {
      // Given
      final form = LoginForm();
      const emailText = "Test";
      form.emailController.text = emailText;

      // When
      final email = form.email;

      // Then
      expect(email, emailText);
    });

    test('get password when password getter is called', () {
      // Given
      final form = LoginForm();
      const passwordText = "Test";
      form.passwordController.text = passwordText;

      // When
      final password = form.password;

      // Then
      expect(password, passwordText);
    });
  });
}
