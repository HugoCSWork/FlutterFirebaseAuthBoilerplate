import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Route Paths should', () {
    test('contain the correct path', () {
      expect(RoutePaths.splash, '/');
      expect(RoutePaths.login, '/login');
      expect(RoutePaths.register, '/register');
      expect(RoutePaths.resetPassword, '/resetPassword');
      expect(RoutePaths.update, '/update');
    });

    test('return all authentication paths when getter authPaths is called', () {
      // Given When
      final paths = RoutePaths.authPaths;

      // Then
      expect(paths.length, 3);
      expect(paths.contains(RoutePaths.login), true);
      expect(paths.contains(RoutePaths.register), true);
      expect(paths.contains(RoutePaths.resetPassword), true);
    });
  });
}
