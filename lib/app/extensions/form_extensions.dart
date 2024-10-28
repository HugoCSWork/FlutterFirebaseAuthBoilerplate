import 'package:flutter/material.dart';

extension FormGlobalKeyExtensions on GlobalKey<FormState> {
  bool get isFormValid => currentState?.validate() ?? false;
}
