import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/register/register_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerProvider = AutoDisposeNotifierProvider<RegisterProvider, AuthStatus>(RegisterProvider.new);

class RegisterProvider extends AutoDisposeNotifier<AuthStatus> {
  @override
  AuthStatus build() => const AuthStatus.initial();

  Future<void> register(RegisterForm form) async {
    state = const AuthStatus.loading();
    try {
      await ref.read(authService).register(username: form.username, email: form.email, password: form.password);
      state = const AuthStatus.success();
    }
    // TODO: Capture specific errors for email already exists.
    on Exception catch (error) {
      print(error);
      state = const AuthStatus.error('Error');
    }
  }
}
