import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/root/root_binding.dart';
import 'package:folio/app/routes/app_pages.dart';
import 'package:folio/app/core/theme/app_theme.dart';

Future<void> main() async {
  runApp(GetMaterialApp(
    initialBinding: RootBinding(),
    initialRoute: AppPages.INITIAL,
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    theme: appThemeData,
  ));
}
