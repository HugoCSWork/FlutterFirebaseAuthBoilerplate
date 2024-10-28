import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/login/login_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = AutoDisposeNotifierProvider<LoginProvider, AuthStatus>(LoginProvider.new);

class LoginProvider extends AutoDisposeNotifier<AuthStatus> {
  @override
  AuthStatus build() => const AuthStatus.initial();

  Future<void> login(LoginForm form) async {
    state = const AuthStatus.loading();
    try {
      await ref.read(authService).login(email: form.email, password: form.password);
      state = const AuthStatus.success();
    }
    // TODO: Capture specific errors for email already exists.
    on Exception catch (_) {
      state = const AuthStatus.error('Error');
    }
  }
}
