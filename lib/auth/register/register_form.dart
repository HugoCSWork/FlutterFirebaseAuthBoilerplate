import 'package:flutter/material.dart';

class RegisterForm {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final TextEditingController confirmPasswordController;

  RegisterForm({String username = '', String email = '', String password = '', String confirmPassword = ''})
      : usernameController = TextEditingController(text: username),
        emailController = TextEditingController(text: email),
        passwordController = TextEditingController(text: password),
        confirmPasswordController = TextEditingController(text: confirmPassword);

  List<TextEditingController> get controllers => [
        usernameController,
        emailController,
        passwordController,
        confirmPasswordController,
      ];

  String get username => usernameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;
}
