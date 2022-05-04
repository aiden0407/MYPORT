import 'package:get/get.dart';
import 'package:folio/app/modules/auth/auth_binding.dart';
import 'package:folio/app/modules/auth/auth_forget/auth_forget_binding.dart';
import 'package:folio/app/modules/auth/auth_forget/auth_forget_view.dart';
import 'package:folio/app/modules/auth/auth_view.dart';
import 'package:folio/app/modules/landing/landing_binding.dart';
import 'package:folio/app/modules/landing/landing_view.dart';
import 'package:folio/app/modules/root/root_binding.dart';
import 'package:folio/app/modules/root/root_view.dart';
import 'package:folio/app/modules/signup/signup_binding.dart';
import 'package:folio/app/modules/signup/signup_view.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.LANDING,
      page: () => LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGET,
      page: () => AuthForgetView(),
      binding: AuthForgetBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
  ];
}
