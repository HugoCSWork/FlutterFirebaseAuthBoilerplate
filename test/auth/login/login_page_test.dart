import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';
import '../../widget_tester_extension.dart';

void main() {
  group('Login Page should', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    testWidgets("""validate all fields with errors when submitted with bad values, then remove 
    errors when field are populated with valid data and submit data on login button pressed""",
        (WidgetTester tester) async {
      // Given
      const email = 'johndoe@example.com';
      const password = 'Password1!';
      when(mockAuthService.login(email: email, password: password))
          .thenAnswer((_) async => await Future.delayed(const Duration(seconds: 2)));

      await tester.pumpWidgetProvider(
        overrides: [authService.overrideWithValue(mockAuthService)],
        child: const LoginPage(),
      );
      final emailField = find.byKey(const Key('email_form_field'));
      final passwordField = find.byKey(const Key('password_form_field'));
      final loginButton = find.byKey(const Key('login_button'));
      const loginFormErrorKey = Key('login_form_error');
      const loginIgnorePointer = Key('login_page_ignore_pointer');

      expect(find.text('Field is required'), findsNothing);
      expect(find.byKey(loginFormErrorKey), findsNothing);

      // When
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsNWidgets(2));
      verifyNever(mockAuthService.login(email: anyNamed('email'), password: anyNamed('password')));

      // When
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsNothing);

      // When
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Then
      var ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(loginIgnorePointer));
      expect(ignorePointer.ignoring, true);

      // When
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Then
      verify(mockAuthService.login(email: email, password: password)).called(1);
      ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(loginIgnorePointer));
      expect(ignorePointer.ignoring, false);
    });

    testWidgets('Show Error message when login fails', (WidgetTester tester) async {
      // Given
      const email = 'johndoe@example.com';
      const password = 'Password1!';
      when(mockAuthService.login(email: email, password: password)).thenThrow(Exception());

      await tester.pumpWidgetProvider(
        overrides: [authService.overrideWithValue(mockAuthService)],
        child: const LoginPage(),
      );
      final emailField = find.byKey(const Key('email_form_field'));
      final passwordField = find.byKey(const Key('password_form_field'));
      final loginButton = find.byKey(const Key('login_button'));
      const loginFormErrorKey = Key('login_form_error');
      expect(find.byKey(loginFormErrorKey), findsNothing);

      // When
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(loginFormErrorKey), findsOneWidget);
      verify(mockAuthService.login(email: email, password: password)).called(1);
    });

    testWidgets('navigate to register page when "GO TO REGISTER" button is pressed', (WidgetTester tester) async {
      // Given
      await tester.pumpWidgetProviderWithRoutes(initialRoute: RoutePaths.login);

      // When
      await tester.tap(find.byKey(const Key('go_to_register_button')));
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(const Key('register_page')), findsOneWidget);
    });

    testWidgets('navigate to reset password page when "RESET PASSWORD" button is pressed', (WidgetTester tester) async {
      // Given
      await tester.pumpWidgetProviderWithRoutes(initialRoute: RoutePaths.login);

      // When
      await tester.tap(find.byKey(const Key('go_to_reset_password_button')));
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(const Key('reset_password_page')), findsOneWidget);
    });
  });
}
