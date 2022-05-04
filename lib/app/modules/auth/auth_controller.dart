import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/data/repository/repository.dart';

class AuthController extends GetxController {
  final MyRepository repository;
  AuthController({required this.repository}) : assert(repository != null);

  final keyIntroScreen = GlobalKey<IntroductionScreenState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  login(email, password) async {
    await repository.postLogIn(email, password).then((login_result) async {
      if(login_result){
        Get.offAllNamed('/root');
      } else {
        simpleDialog(100,"이메일 또는 비밀번호를 다시 확인해주세요");
      }
    });
  }


}
