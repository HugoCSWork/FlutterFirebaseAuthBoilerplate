import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/app/router/router.dart';
import 'package:auth_boilerplate/auth/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../mocks/mocks.mocks.dart';
import '../../widget_tester_extension.dart';

void main() {
  group('Router Redirect should', () {
    testWidgets('redirect to login if unauthenticated and on splash page', (tester) async {
      // Given
      final unauthenticatedStream = Stream<User?>.value(null);
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => unauthenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!);

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.login);
    });

    testWidgets('redirect to login if unauthenticated and not on auth page', (tester) async {
      // Given
      final unauthenticatedStream = Stream<User?>.value(null);
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => unauthenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!)..go(RoutePaths.update);
      await tester.pumpAndSettle();

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.login);
    });

    testWidgets('not redirect if unauthenticated and on auth page', (tester) async {
      // Given
      final unauthenticatedStream = Stream<User?>.value(null);
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => unauthenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!)..go(RoutePaths.register);
      await tester.pumpAndSettle();

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.register);
    });

    testWidgets('redirect to update if authenticated and on splash screen', (tester) async {
      // Given
      final authenticatedStream = Stream<User?>.value(MockUser());
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => authenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!);

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.update);
    });

    testWidgets('redirect to update if authenticated and on auth screen', (tester) async {
      // Given
      final authenticatedStream = Stream<User?>.value(MockUser());
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => authenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!)..go(RoutePaths.login);
      await tester.pumpAndSettle();

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.update);
    });

    testWidgets('not redirect if authenticated and moving to another authenticated screen', (tester) async {
      // Given
      final authenticatedStream = Stream<User?>.value(MockUser());
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => authenticatedStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!)..go(RoutePaths.update);
      await tester.pumpAndSettle();

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.update);
    });

    testWidgets('not redirect and stay on Splash if authState is loading', (tester) async {
      // Given
      const loadingStream = Stream<User?>.empty();
      await tester.pumpWidgetProviderWithExistingRouter(
        overrides: [authStateChangesProvider.overrideWith((ref) => loadingStream)],
      );

      // When
      final router = GoRouter.of(navigatonKey.currentContext!);

      // Then
      expect(router.routerDelegate.currentConfiguration.uri.toString(), RoutePaths.splash);
    });
  });

  group('Router Routes should', () {
    test('return list of routes when list getter is called', () {
      // Given
      final expectedRoutes = [
        RoutePaths.splash,
        RoutePaths.register,
        RoutePaths.login,
        RoutePaths.resetPassword,
        RoutePaths.update,
      ];

      // When
      final routes = Routes.list.whereType<GoRoute>().map((route) => route.path).toList();

      // Then
      expect(routes.length, 5);
      for (var expectedRoute in expectedRoutes) {
        expect(routes, contains(expectedRoute));
      }
    });
  });
}
