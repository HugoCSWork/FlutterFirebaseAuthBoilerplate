import 'package:auth_boilerplate/auth/shared/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class UsernameFormField extends StatelessWidget {
  final TextEditingController controller;
  const UsernameFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWrapper(
      key: const Key('username_form_field_wrapper'),
      title: 'Username',
      child: TextFormField(
        key: const Key('username_form_field'),
        controller: controller,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'Field is required'),
          FormBuilderValidators.minLength(3, errorText: 'Username must be atleast 3 characters'),
          FormBuilderValidators.maxLength(15, errorText: 'Username must be less than 15 characters'),
          // TODO: Add custom to find prevent bad language
        ]),
      ),
    );
  }
}
