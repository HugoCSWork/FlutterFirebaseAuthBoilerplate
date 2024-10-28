import 'package:auth_boilerplate/auth/shared/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController password;
  const ConfirmPasswordFormField(this.controller, this.password, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWrapper(
      key: const Key('confirm_password_form_field_wrapper'),
      title: 'Confirm Password',
      child: TextFormField(
        key: const Key('confirm_password_form_field'),
        controller: controller,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'Field is required'),
          (val) {
            if (password.text.isEmpty || password.text != val) {
              return "Passwords don't match";
            }
            return null;
          }
        ]),
      ),
    );
  }
}
