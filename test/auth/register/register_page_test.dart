import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';
import '../../widget_tester_extension.dart';

void main() {
  group('Register Page should', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    testWidgets("""validate all fields with errors when submitted with bad values, then remove 
    errors when field are populated with valid data and submit data on register button pressed""",
        (WidgetTester tester) async {
      // Given
      const username = "johndoe";
      const email = "johndoe@example.com";
      const password = "Password1!";
      const confirmPassword = "Password1!";
      when(mockAuthService.register(username: username, email: email, password: password))
          .thenAnswer((_) async => await Future.delayed(const Duration(seconds: 2)));

      await tester.pumpWidgetProvider(
        overrides: [authService.overrideWithValue(mockAuthService)],
        child: const RegisterPage(),
      );
      final usernameField = find.byKey(const Key('username_form_field'));
      final emailField = find.byKey(const Key('email_form_field'));
      final passwordField = find.byKey(const Key('password_form_field'));
      final confirmPasswordField = find.byKey(const Key('confirm_password_form_field'));
      final registerButton = find.byKey(const Key('register_button'));
      const registerIgnorePointer = Key('register_page_ignore_pointer');

      expect(find.text('Field is required'), findsNothing);

      // When
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsNWidgets(4));
      verifyNever(mockAuthService.register(username: username, email: email, password: password));

      // When
      await tester.enterText(usernameField, username);
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.enterText(confirmPasswordField, confirmPassword);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsNothing);

      // When
      await tester.tap(registerButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Then
      var ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(registerIgnorePointer));
      expect(ignorePointer.ignoring, true);

      // When
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Then
      verify(mockAuthService.register(username: username, email: email, password: password)).called(1);
      ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(registerIgnorePointer));
      expect(ignorePointer.ignoring, false);
    });

    testWidgets('Show Error message when register fails', (WidgetTester tester) async {
      // Given
      const username = "johndoe";
      const email = 'johndoe@example.com';
      const password = 'Password1!';
      const confirmPassword = "Password1!";
      when(mockAuthService.register(username: username, email: email, password: password)).thenThrow(Exception());

      await tester.pumpWidgetProvider(
        overrides: [authService.overrideWithValue(mockAuthService)],
        child: const RegisterPage(),
      );

      final usernameField = find.byKey(const Key('username_form_field'));
      final emailField = find.byKey(const Key('email_form_field'));
      final passwordField = find.byKey(const Key('password_form_field'));
      final confirmPasswordField = find.byKey(const Key('confirm_password_form_field'));
      final registerButton = find.byKey(const Key('register_button'));
      const registerFormErrorKey = Key('register_form_error');
      expect(find.byKey(registerFormErrorKey), findsNothing);

      // When
      await tester.enterText(usernameField, username);
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.enterText(confirmPasswordField, confirmPassword);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(registerFormErrorKey), findsOneWidget);
      verify(mockAuthService.register(username: username, email: email, password: password)).called(1);
    });

    testWidgets('navigate to login page when "GO TO LOGIN" button is pressed', (WidgetTester tester) async {
      // Given
      await tester.pumpWidgetProviderWithRoutes(initialRoute: RoutePaths.register);

      // When
      await tester.tap(find.byKey(const Key('go_to_login_button')));
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(const Key('login_page')), findsOneWidget);
    });
  });
}
