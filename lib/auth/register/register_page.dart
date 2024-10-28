import 'package:auth_boilerplate/app/extensions/form_extensions.dart';
import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/hooks/use_form_validation.dart';
import 'package:auth_boilerplate/auth/register/components/register_button.dart';
import 'package:auth_boilerplate/auth/register/register_form.dart';
import 'package:auth_boilerplate/auth/register/register_provider.dart';
import 'package:auth_boilerplate/auth/shared/confirm_password_form_field.dart';
import 'package:auth_boilerplate/auth/shared/email_form_field.dart';
import 'package:auth_boilerplate/auth/shared/password_form_field.dart';
import 'package:auth_boilerplate/auth/shared/username_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>(debugLabel: 'register_page_form'));
    final registerModel = useMemoized(() => RegisterForm());
    final hasSubmitted = useState<bool>(false);
    useFormValidation(formKey: formKey, controllers: registerModel.controllers, hasSubmitted: hasSubmitted);

    final status = ref.watch(registerProvider);

    return IgnorePointer(
      key: const Key('register_page_ignore_pointer'),
      ignoring: status.disabled,
      child: Scaffold(
        key: const Key('register_page'),
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
                        const Text('Register'),
                        const SizedBox(height: 20),
                        UsernameFormField(registerModel.usernameController),
                        const SizedBox(height: 10),
                        EmailFormField(registerModel.emailController),
                        PasswordFormField(registerModel.passwordController),
                        const SizedBox(height: 10),
                        ConfirmPasswordFormField(
                            registerModel.confirmPasswordController, registerModel.passwordController),
                        const SizedBox(height: 20),
                        RegisterButton(
                          onPressed: () {
                            hasSubmitted.value = true;
                            if (formKey.isFormValid) {
                              ref.read(registerProvider.notifier).register(registerModel);
                            }
                          },
                        ),
                        // TODO:Improve this
                        if (status.hasError)
                          const Text(key: Key('register_form_error'), 'Error registering. Please try again'),
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
