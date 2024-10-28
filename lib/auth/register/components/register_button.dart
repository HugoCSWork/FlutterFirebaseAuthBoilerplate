import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(registerProvider);

    /// TODO: Customise button to have disabled state / Loading spinner
    /// In a real application this button might be generic and this widget is not needed
    return TextButton(
      key: const Key('register_button'),
      onPressed: status.initial ? onPressed : null,
      child: const Text('Register'),
    );
  }
}
