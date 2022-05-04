import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/modules/auth/widget/authscreen_widget.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Column(
            children: [
              Container(
                child: AuthScreenWidget(controller: controller),
                height: Get.height * 0.7,
              ),
              Container(
                height: Get.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Get.width * 0.8,
                        height: Get.height * 0.065,
                        child: TextButton(
                            onPressed: () {Get.toNamed('/signup');},
                            child: Text("회원가입", style: inTextButton),
                            style: textButtonStyle)),
                    SizedBox(height: Get.height * 0.01),
                    SizedBox(
                        width: Get.width * 0.8,
                        height: Get.height * 0.065,
                        child: OutlinedButton(
                            child: Text("로그인", style: inOutlinedButton),
                            style: OutlinedButtonStyle,
                            onPressed: () { showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                context: context,
                                builder: (context){
                                  return Container(
                                    padding: EdgeInsets.only(top: Get.height*0.05,left: Get.width * 0.1, right: Get.width * 0.1),
                                    height: Get.height*0.48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(16.0),
                                          topRight: const Radius.circular(16.0),
                                        ),
                                        color: Colors.white
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("로그인",style: normal_f33_16),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: Get.height * 0.07,
                                          child: TextField(
                                            decoration: buildInputDecoration('이메일 입력'),
                                            controller: controller.emailController,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: Get.height * 0.07,
                                          child: TextField(
                                            obscureText: true,
                                            decoration: buildInputDecoration('비밀번호 입력'),
                                            controller: controller.passwordController,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Center(child:
                                          GestureDetector(
                                              onTap: (){
                                                Get.toNamed('/forget');
                                              },
                                              child: Text("아이디/비밀번호가 기억나지 않으신가요?",style: normal_fBB_12_underline),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          height: Get.height * 0.15,
                                          width: Get.width * 0.8,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.8,
                                                height: Get.height * 0.065,
                                                child: GetBuilder<AuthController>(
                                                  init: controller,
                                                  builder: (_) => TextButton(
                                                      onPressed: () {
                                                        controller.login(controller.emailController.text, controller.passwordController.text);
                                                      },
                                                      child: Text("로그인", style: inTextButton),
                                                      style: textButtonStyle
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                            },
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
