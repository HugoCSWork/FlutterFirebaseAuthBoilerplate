// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('useFormValidation hook should', () {
    testWidgets('add and remove listeners correctly', (tester) async {
      // Given
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();

      // When
      await tester.pumpWidget(HookBuilder(
        builder: (context) {
          return TestFormValidationWidget(formKey: formKey, controller: controller, validator: (_) => null);
        },
      ));
      await tester.pump();

      // Then
      expect(controller.hasListeners, true);

      // When
      await tester.pumpWidget(Container());

      // Then
      expect(controller.hasListeners, false);
    });
  });
}

class TestFormValidationWidget extends HookWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TestFormValidationWidget({super.key, required this.formKey, required this.controller, required this.validator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(controller: controller, validator: validator),
              TextButton(
                key: const Key('test_form_validation_key'),
                onPressed: () => formKey.currentState!.validate(),
                child: const Text('Validate'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
