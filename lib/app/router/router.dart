import 'package:auth_boilerplate/app/router/route_paths.dart';
import 'package:auth_boilerplate/auth/firebase_service.dart';
import 'package:auth_boilerplate/auth/login/login_page.dart';
import 'package:auth_boilerplate/auth/register/register_page.dart';
import 'package:auth_boilerplate/auth/reset_password/reset_password_page.dart';
import 'package:auth_boilerplate/auth/update/update_page.dart';
import 'package:auth_boilerplate/auth/util/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigatonKey = GlobalKey<NavigatorState>();

final routerProvider = NotifierProvider<RouterProvider, GoRouter>(RouterProvider.new);

class RouterProvider extends Notifier<GoRouter> {
  @override
  GoRouter build() {
    final authState = ref.watch(authStateChangesProvider);

    return GoRouter(
        navigatorKey: navigatonKey,
        debugLogDiagnostics: kDebugMode,
        initialLocation: RoutePaths.splash,
        routes: Routes.list,
        redirect: (context, state) {
          if (authState.isLoading || authState.hasError) return null;

          final hasAuth = authState.valueOrNull != null;

          if (state.matchedLocation == RoutePaths.splash) {
            return hasAuth ? RoutePaths.update : RoutePaths.login;
          }
          if (RoutePaths.authPaths.any((path) => path == state.matchedLocation)) {
            return hasAuth ? RoutePaths.update : null;
          }

          return hasAuth ? null : RoutePaths.login;
        });
  }
}

class Routes {
  static List<RouteBase> get list => <RouteBase>[
        GoRoute(
          path: RoutePaths.splash,
          name: RoutePaths.splash,
          builder: (_, __) => const SplashPage(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RoutePaths.register,
          builder: (_, __) => const RegisterPage(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RoutePaths.login,
          builder: (_, __) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.resetPassword,
          name: RoutePaths.resetPassword,
          builder: (_, __) => const ResetPasswordPage(),
        ),
        GoRoute(
          path: RoutePaths.update,
          name: RoutePaths.update,
          builder: (_, __) => const UpdatePage(),
        ),
      ];
}
