import 'package:auth_boilerplate/auth/shared/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Password Form Field should', () {
    late TextEditingController controller;
    const key = Key('password_form_field');

    setUp(() => controller = TextEditingController());

    tearDown(() => controller.dispose());

    testWidgets('show error message if password is empty', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Field is required');
    });

    testWidgets('show error message if password is less than 8 characters', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'testing');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Password must be atleast 8 characters');
    });

    testWidgets('show error message if password is greater than 25 characters', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'testpasswordisveryextremelylong');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Password must be less than 25 characters');
    });

    testWidgets('show error message if password does not have a uppercase character', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'password');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Password must have atleast 1 uppercase character');
    });

    testWidgets('show error message if password does not have a number', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'Password');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Password must have atleast 1 numeric character');
    });

    testWidgets('show error message if password does not have a special character', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'Password1');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Password must have atleast 1 special character');
    });

    testWidgets('show no error message if password is valid', (tester) async {
      // Given
      await tester.pumpFormWidget(PasswordFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'Password1!');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, null);
    });
  });
}
