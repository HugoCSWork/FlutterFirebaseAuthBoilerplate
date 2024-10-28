import 'package:auth_boilerplate/app/extensions/form_extensions.dart';
import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/hooks/use_form_validation.dart';
import 'package:auth_boilerplate/auth/login/components/login_button.dart';
import 'package:auth_boilerplate/auth/login/login_form.dart';
import 'package:auth_boilerplate/auth/login/login_provider.dart';
import 'package:auth_boilerplate/auth/shared/email_form_field.dart';
import 'package:auth_boilerplate/auth/shared/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>(debugLabel: 'register_page_form'));
    final loginModel = useMemoized(() => LoginForm());
    final hasSubmitted = useState<bool>(false);

    useFormValidation(formKey: formKey, controllers: loginModel.controllers, hasSubmitted: hasSubmitted);

    final status = ref.watch(loginProvider);

    return IgnorePointer(
      key: const Key('login_page_ignore_pointer'),
      ignoring: status.disabled,
      child: Scaffold(
        key: const Key('login_page'),
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
                        const Text('Login'),
                        const SizedBox(height: 20),
                        EmailFormField(loginModel.emailController),
                        PasswordFormField(loginModel.passwordController),
                        const SizedBox(height: 20),
                        LoginButton(
                          onPressed: () {
                            hasSubmitted.value = true;
                            if (formKey.isFormValid) {
                              ref.read(loginProvider.notifier).login(loginModel);
                            }
                          },
                        ),
                        // TODO:Improve this
                        if (status.hasError)
                          const Text(key: Key('login_form_error'), 'Error registering. Please try again'),
                        const SizedBox(height: 20),
                        TextButton(
                          key: const Key('go_to_register_button'),
                          onPressed: () => context.goNamed(RoutePaths.register),
                          child: const Text('GO TO REGISTER'),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          key: const Key('go_to_reset_password_button'),
                          onPressed: () => context.goNamed(RoutePaths.resetPassword),
                          child: const Text('RESET PASSWORD'),
                        ),
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
