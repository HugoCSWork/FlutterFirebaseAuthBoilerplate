import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:auth_boilerplate/auth/login/login_form.dart';
import 'package:auth_boilerplate/auth/login/login_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;
  final listener = StateListener();
  group('Login Provider should', () {
    setUp(() {
      mockAuthService = MockAuthService();
      container = ProviderContainer(overrides: [
        authService.overrideWithValue(mockAuthService),
      ]);
      container.listen(loginProvider, listener.call, fireImmediately: true);
    });

    test('call service to authenticate credentials and set status to success if it succeeded', () async {
      // Given
      final form = LoginForm(email: 'email', password: 'password');
      when(mockAuthService.login(email: 'email', password: 'password')).thenAnswer((_) async {});

      // When
      await container.read(loginProvider.notifier).login(form);

      // Then
      verify(mockAuthService.login(email: 'email', password: 'password')).called(1);
      expect(container.read(loginProvider), const AuthStatus.success());
    });
    test('call service to authenticate credentials and set status to error if it failed', () async {
      // Given
      final form = LoginForm(email: 'email', password: 'password');
      when(mockAuthService.login(email: 'email', password: 'password')).thenThrow(Exception());

      // When
      await container.read(loginProvider.notifier).login(form);

      // Then
      verify(mockAuthService.login(email: 'email', password: 'password')).called(1);
      expect(container.read(loginProvider), const AuthStatus.error('Error'));
    });
  });
}
