import 'package:flutter/material.dart';

class LoginForm {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginForm({String email = '', String password = ''})
      : emailController = TextEditingController(text: email),
        passwordController = TextEditingController(text: password);

  List<TextEditingController> get controllers => [emailController, passwordController];

  String get email => emailController.text;
  String get password => passwordController.text;
}
