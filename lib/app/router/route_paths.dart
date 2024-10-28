class RoutePaths {
  static String get splash => '/';
  static String get login => '/login';
  static String get register => '/register';
  static String get resetPassword => '/resetPassword';
  static String get update => '/update';

  static List<String> get authPaths => [login, register, resetPassword];
}
