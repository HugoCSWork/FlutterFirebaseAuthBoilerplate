import 'package:auth_boilerplate/auth/auth_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthStatusExtensions disabled getter should', () {
    test('return true for loading status', () {
      // Given
      const authStatusLoading = AuthStatus.loading();

      // When
      final result = authStatusLoading.disabled;

      // Then
      expect(result, isTrue);
    });

    test('return false for initial status', () {
      // Given
      const authStatusInitial = AuthStatus.initial();

      // When
      final result = authStatusInitial.disabled;

      // Then
      expect(result, isFalse);
    });
  });

  group('AuthStatusExtensions hasSuccess getter should', () {
    test('return true for success status', () {
      // Given
      const authStatusLoading = AuthStatus.success();

      // When
      final result = authStatusLoading.hasSuccess;

      // Then
      expect(result, isTrue);
    });

    test('return false for initial status', () {
      // Given
      const authStatusInitial = AuthStatus.initial();

      // When
      final result = authStatusInitial.hasSuccess;

      // Then
      expect(result, isFalse);
    });
  });

  group('AuthStatusExtensions initial getter should', () {
    test('return true for initial status', () {
      // Given
      const authStatusInitial = AuthStatus.initial();

      // When
      final result = authStatusInitial.initial;

      // Then
      expect(result, isTrue);
    });

    test('return false for loading status', () {
      // Given
      const authStatusLoading = AuthStatus.loading();

      // When
      final result = authStatusLoading.initial;

      // Then
      expect(result, isFalse);
    });
  });

  group('AuthStatusExtensions map function should', () {
    test('return correct value for initial status', () {
      // Given
      const authStatusInitial = AuthStatus.initial();

      // When
      final result = authStatusInitial.map(
        initial: () => 'Initial State',
        loading: () => 'Loading State',
        success: () => 'Success State',
        error: (error) => 'Error State: $error',
      );

      // Then
      expect(result, 'Initial State');
    });

    test('return correct value for loading status', () {
      // Given
      const authStatusLoading = AuthStatus.loading();

      // When
      final result = authStatusLoading.map(
        initial: () => 'Initial State',
        loading: () => 'Loading State',
        success: () => 'Success State',
        error: (error) => 'Error State: $error',
      );

      // Then
      expect(result, 'Loading State');
    });

    test('return correct value for success status', () {
      // Given
      const authStatusSuccess = AuthStatus.success();

      // When
      final result = authStatusSuccess.map(
        initial: () => 'Initial State',
        loading: () => 'Loading State',
        success: () => 'Success State',
        error: (error) => 'Error State: $error',
      );

      // Then
      expect(result, 'Success State');
    });

    test('return correct value for error status', () {
      // Given
      const authStatusError = AuthStatus.error('Sample error');

      // When
      final result = authStatusError.map(
        initial: () => 'Initial State',
        loading: () => 'Loading State',
        success: () => 'Success State',
        error: (error) => 'Error State: $error',
      );

      // Then
      expect(result, 'Error State: Sample error');
    });

    test('throw ArgumentError for unknown status', () {
      // Given
      const unknownStatus = _UnknownStatus();

      // When & Then
      expect(
        () => unknownStatus.map(
          initial: () => 'Initial State',
          loading: () => 'Loading State',
          success: () => 'Success State',
          error: (error) => 'Error State: $error',
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', contains('Unknown Status type'))),
      );
    });
  });

  group('AuthStatusExtensions  maybeMap function should', () {
    test('return correct value for initial status', () {
      // Given
      const authStatusInitial = AuthStatus.initial();

      // When
      final result = authStatusInitial.maybeMap(
        initial: () => 'Initial State',
        orElse: () => 'orElse state',
      );

      // Then
      expect(result, 'Initial State');
    });

    test('return correct value for loading status', () {
      // Given
      const authStatusLoading = AuthStatus.loading();

      // When
      final result = authStatusLoading.maybeMap(
        loading: () => 'Loading State',
        orElse: () => 'orElse state',
      );

      // Then
      expect(result, 'Loading State');
    });

    test('return correct value for success status', () {
      // Given
      const authStatusSuccess = AuthStatus.success();

      // When
      final result = authStatusSuccess.maybeMap(
        success: () => 'Success State',
        orElse: () => 'orElse state',
      );

      // Then
      expect(result, 'Success State');
    });

    test('return correct value for error status', () {
      // Given
      const authStatusError = AuthStatus.error('Sample error');

      // When
      final result = authStatusError.maybeMap(
        error: (error) => 'Error State: $error',
        orElse: () => 'orElse state',
      );

      // Then
      expect(result, 'Error State: Sample error');
    });

    test('return orElse value if status option is not in the maybeMap', () {
      // Given
      const authStatusError = AuthStatus.error('Sample error');

      // When
      final result = authStatusError.maybeMap(
        success: () => 'Success State',
        loading: () => 'Loading State',
        initial: () => 'Initial State',
        orElse: () => 'orElse state',
      );

      // Then
      expect(result, 'orElse state');
    });

    test('throw ArgumentError for unknown status', () {
      // Given
      const unknownStatus = _UnknownStatus();

      // When & Then
      expect(
        () => unknownStatus.maybeMap(
          initial: () => 'Initial State',
          loading: () => 'Loading State',
          success: () => 'Success State',
          error: (error) => 'Error State: $error',
          orElse: () => 'orElse state',
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message', contains('Unknown Status type'))),
      );
    });
  });
}

class _UnknownStatus extends AuthStatus {
  const _UnknownStatus() : super();
}
