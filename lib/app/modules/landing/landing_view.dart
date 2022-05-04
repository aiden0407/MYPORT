import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/modules/landing/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mpBL,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white54,
        ),
      ),
    );
  }
}
