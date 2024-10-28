import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';
import '../../widget_tester_extension.dart';

void main() {
  group('Reset Password Page should', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    testWidgets("""validate all fields with errors when submitted with bad values, then remove 
    errors when field are populated with valid data and submit data on reset password button pressed""",
        (WidgetTester tester) async {
      // Given
      const email = 'johndoe@example.com';
      when(mockAuthService.resetPassword(email: email))
          .thenAnswer((_) async => await Future.delayed(const Duration(seconds: 2)));

      await tester.pumpWidgetProvider(
        overrides: [authService.overrideWithValue(mockAuthService)],
        child: const ResetPasswordPage(),
      );
      final emailField = find.byKey(const Key('email_form_field'));
      final resetPasswordButton = find.byKey(const Key('reset_password_button'));
      const resetPasswordErrorKey = Key('reset_password_form_error');
      const resetPasswordIgnorePointer = Key('reset_password_page_ignore_pointer');

      expect(find.text('Field is required'), findsNothing);
      expect(find.byKey(resetPasswordErrorKey), findsNothing);

      // When
      await tester.tap(resetPasswordButton);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsOneWidget);
      verifyNever(mockAuthService.resetPassword(email: anyNamed('email')));
      expect(find.byKey(const Key('reset_password_success_message')), findsNothing);

      ; // When
      await tester.enterText(emailField, email);
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Field is required'), findsNothing);

      // When
      await tester.tap(resetPasswordButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Then
      var ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(resetPasswordIgnorePointer));
      expect(ignorePointer.ignoring, true);

      // When
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Then
      verify(mockAuthService.resetPassword(email: email)).called(1);
      ignorePointer = tester.firstWidget<IgnorePointer>(find.byKey(resetPasswordIgnorePointer));
      expect(ignorePointer.ignoring, false);
      expect(find.byKey(const Key('reset_password_success_message')), findsOneWidget);
    });

    testWidgets('navigate to login page when "GO TO LOGIN" button is pressed', (WidgetTester tester) async {
      // Given
      await tester.pumpWidgetProviderWithRoutes(initialRoute: RoutePaths.resetPassword);

      // When
      await tester.tap(find.byKey(const Key('go_to_login_button')));
      await tester.pumpAndSettle();

      // Then
      expect(find.byKey(const Key('login_page')), findsOneWidget);
    });
  });
}
