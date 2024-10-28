import 'package:auth_boilerplate/auth/shared/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWrapper(
      key: const Key('password_form_field_wrapper'),
      title: 'Password',
      child: TextFormField(
        key: const Key('password_form_field'),
        controller: controller,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'Field is required'),
          FormBuilderValidators.minLength(8, errorText: 'Password must be atleast 8 characters'),
          FormBuilderValidators.maxLength(25, errorText: 'Password must be less than 25 characters'),
          FormBuilderValidators.hasUppercaseChars(errorText: 'Password must have atleast 1 uppercase character'),
          FormBuilderValidators.hasNumericChars(errorText: 'Password must have atleast 1 numeric character'),
          FormBuilderValidators.hasSpecialChars(errorText: 'Password must have atleast 1 special character'),
        ]),
      ),
    );
  }
}
