import 'package:auth_boilerplate/auth/register/register_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Register Form should', () {
    test('return list of controllers when controllers getter is called', () {
      // Given
      final form = RegisterForm();

      // When
      final controllers = form.controllers;

      // Then
      expect(controllers.length, 4);
      expect(controllers[0], form.usernameController);
      expect(controllers[1], form.emailController);
      expect(controllers[2], form.passwordController);
      expect(controllers[3], form.confirmPasswordController);
    });

    test('get username when username getter is called', () {
      // Given
      final form = RegisterForm();
      const usernameText = "Test";
      form.usernameController.text = usernameText;

      // When
      final username = form.username;

      // Then
      expect(username, usernameText);
    });

    test('get email when email getter is called', () {
      // Given
      final form = RegisterForm();
      const emailText = "Test";
      form.emailController.text = emailText;

      // When
      final email = form.email;

      // Then
      expect(email, emailText);
    });

    test('get password when password getter is called', () {
      // Given
      final form = RegisterForm();
      const passwordText = "Test";
      form.passwordController.text = passwordText;

      // When
      final password = form.password;

      // Then
      expect(password, passwordText);
    });
  });
}
