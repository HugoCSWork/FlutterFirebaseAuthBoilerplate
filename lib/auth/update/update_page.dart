import 'package:auth_boilerplate/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatePage extends ConsumerWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: const Key('update_page'),
      body: Center(
        child: TextButton(
          key: const Key('logout_button'),
          onPressed: () => ref.read(authProvider.notifier).logout(),
          child: const Text('logout'),
        ),
      ),
    );
  }
}
