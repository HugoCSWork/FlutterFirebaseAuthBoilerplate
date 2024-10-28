import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO: Clean this up
extension AuthenticationRobots on WidgetTester {
  Future<void> enterEmail(String value) async => await enterText(find.byKey(const Key('email_form_field')), value);

  Future<void> enterPassword(String value) async =>
      await enterText(find.byKey(const Key('password_form_field')), value);

  Future<void> enterConfirmPassword(String value) async =>
      await enterText(find.byKey(const Key('confirm_password_form_field')), value);

  Future<void> enterUsername(String value) async =>
      await enterText(find.byKey(const Key('username_form_field')), value);

  Future<void> submitRegister() async {
    await pumpAndSettle();
    await tap(find.byKey(const Key('register_button')));
    await pumpAndSettle(const Duration(seconds: 1));
  }

  Future<void> submitLogin() async {
    await pumpAndSettle();
    await tap(find.byKey(const Key('login_button')));
    await pumpAndSettle(const Duration(seconds: 1));
  }

  Future<void> submitResetPassword() async {
    await pumpAndSettle();
    await tap(find.byKey(const Key('reset_password_button')));
    await pumpAndSettle(const Duration(seconds: 1));
  }

  void verifyResetPasswordSent() => expect(find.byKey(const Key('reset_password_success_message')), findsOneWidget);

  void verifyInUpdatePage() => expect(find.byKey(const Key('update_page')), findsOneWidget);
  void verifyInLoginPage() => expect(find.byKey(const Key('login_page')), findsOneWidget);

  Future<void> goToRegister() async {
    await tap(find.byKey(const Key('go_to_register_button')));
    await pumpAndSettle();
  }

  Future<void> goToResetPassword() async {
    await tap(find.byKey(const Key('go_to_reset_password_button')));
    await pumpAndSettle();
  }

  Future<void> clickLogoutButton() async {
    await tap(find.byKey(const Key('logout_button')));
    await pumpAndSettle();
  }
}
