import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resetPasswordProvider = AutoDisposeNotifierProvider<ResetPasswordProvider, AuthStatus>(ResetPasswordProvider.new);

class ResetPasswordProvider extends AutoDisposeNotifier<AuthStatus> {
  @override
  AuthStatus build() => const AuthStatus.initial();

  Future<void> resetPassword(ResetPasswordForm form) async {
    state = const AuthStatus.loading();
    await ref.read(authService).resetPassword(email: form.email).onError((_, __) {
      // TODO: Should we do something on an error? Maybe only network related
    });
    state = const AuthStatus.success();
  }
}
