import 'package:flutter_test/flutter_test.dart';

import 'robots/authentication_robots.dart';
import 'robots/configuration_robots.dart';

void main() {
  group('User Authentication should', () {
    const email = 'johndoe@example.com';
    const password = 'Password1!';
    const username = 'JohnDoe';

    testWidgets('be able to register an account', (tester) async {
      // Given
      await tester.pumpApp();

      // When
      await tester.goToRegister();
      await tester.enterUsername(username);
      await tester.enterEmail(email);
      await tester.enterPassword(password);
      await tester.enterConfirmPassword(password);
      await tester.submitRegister();

      // Then
      tester.verifyInUpdatePage();
    });

    testWidgets('be able to logout to an account', (tester) async {
      // Given
      await tester.pumpApp();
      tester.verifyInUpdatePage();

      // When
      await tester.clickLogoutButton();

      // Then
      tester.verifyInLoginPage();
    });

    testWidgets('be able to request password reset email', (tester) async {
      // Given
      await tester.pumpApp();

      // When
      await tester.goToResetPassword();
      await tester.enterEmail(email);
      await tester.submitResetPassword();

      // Then
      tester.verifyResetPasswordSent();
    });

    testWidgets('be able to login to an account', (tester) async {
      // Given
      await tester.pumpApp();

      // When
      await tester.enterEmail(email);
      await tester.enterPassword(password);
      await tester.submitLogin();

      // Then
      tester.verifyInUpdatePage();
    });
  });

  // Update
}
