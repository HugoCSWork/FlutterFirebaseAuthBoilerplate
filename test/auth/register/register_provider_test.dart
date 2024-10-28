import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/register/register_form.dart';
import 'package:auth_boilerplate/auth/register/register_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;
  final listener = StateListener();
  group('Register Provider should', () {
    setUp(() {
      mockAuthService = MockAuthService();
      container = ProviderContainer(overrides: [
        authService.overrideWithValue(mockAuthService),
      ]);
      container.listen(registerProvider, listener.call, fireImmediately: true);
    });

    test('call service to register an account and set status to success if it succeeded', () async {
      // Given
      final form = RegisterForm(email: 'email', password: 'password', username: 'username');
      when(mockAuthService.register(username: 'username', email: 'email', password: 'password'))
          .thenAnswer((_) async {});

      // When
      await container.read(registerProvider.notifier).register(form);

      // Then
      verify(mockAuthService.register(username: 'username', email: 'email', password: 'password')).called(1);
      expect(container.read(registerProvider), const AuthStatus.success());
    });
    test('call service to register an account and set status to error if it failed', () async {
      // Given
      final form = RegisterForm(email: 'email', password: 'password', username: 'username');
      when(mockAuthService.register(username: 'username', email: 'email', password: 'password')).thenThrow(Exception());

      // When
      await container.read(registerProvider.notifier).register(form);

      // Then
      verify(mockAuthService.register(username: 'username', email: 'email', password: 'password')).called(1);
      expect(container.read(registerProvider), const AuthStatus.error('Error'));
    });
  });
}
