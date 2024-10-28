import 'package:auth_boilerplate/app/extensions/form_extensions.dart';
import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/hooks/use_form_validation.dart';
import 'package:auth_boilerplate/auth/reset_password/components/reset_password_button.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_form.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_provider.dart';
import 'package:auth_boilerplate/auth/shared/email_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO: On success we should probably clear the input field
class ResetPasswordPage extends HookConsumerWidget {
  const ResetPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>(debugLabel: 'register_page_form'));
    final resetPasswordForm = useMemoized(() => ResetPasswordForm());
    final hasSubmitted = useState<bool>(false);

    useFormValidation(formKey: formKey, controllers: resetPasswordForm.controllers, hasSubmitted: hasSubmitted);

    final status = ref.watch(resetPasswordProvider);

    return IgnorePointer(
      key: const Key('reset_password_page_ignore_pointer'),
      ignoring: status.disabled,
      child: Scaffold(
        key: const Key('reset_password_page'),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('Reset Password'),
                        const SizedBox(height: 20),
                        EmailFormField(resetPasswordForm.emailController),
                        const SizedBox(height: 20),
                        ResetPasswordButton(
                          onPressed: () {
                            hasSubmitted.value = true;
                            if (formKey.isFormValid) {
                              ref.read(resetPasswordProvider.notifier).resetPassword(resetPasswordForm);
                            }
                          },
                        ),
                        if (status.hasSuccess)
                          const Text(key: Key('reset_password_success_message'), 'Reset Successfully sent'),
                        const SizedBox(height: 20),
                        TextButton(
                          key: const Key('go_to_login_button'),
                          onPressed: () => context.goNamed(RoutePaths.login),
                          child: const Text('GO TO LOGIN'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
