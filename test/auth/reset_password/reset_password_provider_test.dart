import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_form.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('Login Provider should', () {
    late MockAuthService mockAuthService;
    late ProviderContainer container;
    final listener = StateListener();
    setUp(() {
      mockAuthService = MockAuthService();
      container = ProviderContainer(overrides: [
        authService.overrideWithValue(mockAuthService),
      ]);
      container.listen(resetPasswordProvider, listener.call, fireImmediately: true);
    });

    test('call service to authenticate credentials and set status to success', () async {
      // Given
      const email = "test@test.com";
      final form = ResetPasswordForm(email: email);
      when(mockAuthService.resetPassword(email: email)).thenAnswer((_) async {});

      // When
      await container.read(resetPasswordProvider.notifier).resetPassword(form);

      // Then
      verify(mockAuthService.resetPassword(email: email)).called(1);
      expect(container.read(resetPasswordProvider), const AuthStatus.success());
    });
  });
}
