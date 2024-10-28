import 'package:flutter/material.dart';

class ResetPasswordForm {
  final TextEditingController emailController;

  ResetPasswordForm({String email = ''}) : emailController = TextEditingController(text: email);

  List<TextEditingController> get controllers => [emailController];

  String get email => emailController.text;
}
