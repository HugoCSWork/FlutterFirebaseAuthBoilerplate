import 'package:meta/meta.dart';

@immutable
abstract class AuthStatus {
  const AuthStatus();

  const factory AuthStatus.initial() = _Initial;
  const factory AuthStatus.loading() = _Loading;
  const factory AuthStatus.success() = _Success;
  const factory AuthStatus.error(dynamic error) = _Error;
}

class _Initial extends AuthStatus {
  const _Initial();
}

class _Loading extends AuthStatus {
  const _Loading();
}

class _Success extends AuthStatus {
  const _Success();
}

class _Error extends AuthStatus {
  final dynamic error;
  const _Error(this.error);
}

extension AuthStatusExtensions on AuthStatus {
  bool get hasError => this is _Error;
  bool get hasSuccess => this is _Success;

  bool get disabled => this is _Loading;

  bool get initial => this is _Initial;

  T map<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() success,
    required T Function(dynamic error) error,
  }) {
    switch (this) {
      case _Initial _:
        return initial();

      case _Loading _:
        return loading();

      case _Success _:
        return success();

      case _Error _:
        return error((this as _Error).error);
      default:
        throw ArgumentError('Unknown Status type: $this');
    }
  }

  T maybeMap<T>({
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function(dynamic error)? error,
    required T Function() orElse,
  }) {
    switch (this) {
      case _Initial _:
        return initial != null ? initial() : orElse();

      case _Loading _:
        return loading != null ? loading() : orElse();

      case _Success _:
        return success != null ? success() : orElse();

      case _Error _:
        return error != null ? error((this as _Error).error) : orElse();

      default:
        throw ArgumentError('Unknown Status type: $this');
    }
  }
}
