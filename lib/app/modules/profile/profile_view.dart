import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<ProfileController>(
            init: controller,
            builder: (_) => Text(_.name)
        ),
      ),
    );
  }
}