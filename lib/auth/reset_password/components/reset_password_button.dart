import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const ResetPasswordButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(resetPasswordProvider);

    /// TODO: Customise button to have disabled state / Loading spinner
    /// In a real application this button might be generic and this widget is not needed
    return TextButton(
      key: const Key('reset_password_button'),
      onPressed: status.initial ? onPressed : null,
      child: const Text('Reset'),
    );
  }
}
