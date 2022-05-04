part of './app_pages.dart';

abstract class Routes {
  Routes._();

  static const LANDING = _Paths.LANDING;
  static const AUTH = _Paths.AUTH;
  static const FORGET = _Paths.FORGET;
  static const SIGNUP = _Paths.SIGNUP;
  static const ROOT = _Paths.ROOT;
}

abstract class _Paths {
  static const LANDING = '/';
  static const AUTH = '/auth';
  static const FORGET = '/forget';
  static const SIGNUP = '/signup';
  static const ROOT = '/root';
}