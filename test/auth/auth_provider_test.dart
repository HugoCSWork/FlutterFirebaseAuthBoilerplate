import 'package:auth_boilerplate/auth/auth_provider.dart';
import 'package:auth_boilerplate/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';
import '../util/riverpod_utils.dart';

void main() {
  group('Auth Provider should', () {
    late MockAuthService mockAuthService;
    late ProviderContainer container;

    setUp(() {
      mockAuthService = MockAuthService();
      container = createContainer(overrides: [authService.overrideWithValue(mockAuthService)]);
    });
    test('call auth service to logout when logout function is called', () async {
      // Given
      when(mockAuthService.logout()).thenAnswer((_) async {});

      // When
      await container.read(authProvider.notifier).logout();

      // Then
      verify(mockAuthService.logout()).called(1);
    });
  });
}
