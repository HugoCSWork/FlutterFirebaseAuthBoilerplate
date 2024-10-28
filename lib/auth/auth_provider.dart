import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = AutoDisposeNotifierProvider<AuthProvider, AuthStatus>(AuthProvider.new);

// TODO: Add other auth providers
class AuthProvider extends AutoDisposeNotifier<AuthStatus> {
  @override
  AuthStatus build() => const AuthStatus.initial();

  Future<void> logout() async => await ref.read(authService).logout();
}
