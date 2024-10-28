import 'package:auth_boilerplate/auth/shared/username_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widget_tester_extension.dart';

void main() {
  group('Username Form Field should', () {
    late TextEditingController controller;
    const key = Key('username_form_field');

    setUp(() => controller = TextEditingController());

    tearDown(() => controller.dispose());

    testWidgets('show error message if username is empty', (tester) async {
      // Given
      await tester.pumpFormWidget(UsernameFormField(controller));

      // When
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Field is required');
    });

    testWidgets('show error message if username is less than 3 characters', (tester) async {
      // Given
      await tester.pumpFormWidget(UsernameFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'ta');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Username must be atleast 3 characters');
    });

    testWidgets('show error message if username is greater than 15 characters', (tester) async {
      // Given
      await tester.pumpFormWidget(UsernameFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'testusernametoolong');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, 'Username must be less than 15 characters');
    });

    testWidgets('show no error message if username is valid', (tester) async {
      // Given
      await tester.pumpFormWidget(UsernameFormField(controller));

      // When
      await tester.enterText(find.byKey(key), 'username');
      await tester.tap(find.byKey(const Key('form_button')));
      await tester.pumpAndSettle();

      // Then
      final formFieldState = tester.state<FormFieldState<String>>(find.byKey(key));
      expect(formFieldState.errorText, null);
    });
  });
}
