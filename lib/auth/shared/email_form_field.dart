import 'package:auth_boilerplate/auth/shared/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  const EmailFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWrapper(
      key: const Key('email_form_field_wrapper'),
      title: 'Email',
      child: TextFormField(
        key: const Key('email_form_field'),
        controller: controller,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'Field is required'),
          FormBuilderValidators.email(errorText: 'Please enter a valid email'),
        ]),
      ),
    );
  }
}
