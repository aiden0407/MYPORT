import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/auth/auth_forget/auth_forget_controller.dart';

class AuthForgetView extends GetView<AuthForgetController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 10,
        elevation: 1,
        backgroundColor: Colors.white,
        bottom: TabBar(
            indicatorColor: mpBL,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: semibold_f00_18,
            labelColor: Colors.black,
            unselectedLabelColor: fAA,
            controller: controller.tabController,
            tabs: [
              Tab(text: "이메일 찾기"),
              Tab(text: "비밀번호 찾기"),
            ]),
      ),
      body: Center(
        child: TabBarView(
          controller: controller.tabController,
          children: [
            Column(
              children: [
                SizedBox(height: 40),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextField(
                    onChanged: (value) {
                      controller.findEmailButtonValidator();
                    },
                    controller: controller.nameController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "이름 입력",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: Get.width*0.8,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            controller.findEmailButtonValidator();
                          },
                          controller: controller.birthController,
                          style: TextStyle(fontSize: 20),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9]')),
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration: InputDecoration(
                            hintText: "생년월일",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Text("    -     ●●●●●●●", style:bold_f00_21)
                    ],
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.065,
                  child: GetBuilder<AuthForgetController>(
                    init: controller,
                    builder: (_) => TextButton(
                      onPressed: _.findEmailValid.value? () {
                        _.getFindEmail(_.nameController.text, _.birthController.text);
                      }:null,
                      child: Text("확인",
                          style: _.findEmailValid.value
                              ? inTextButton
                              : inTextButtonDisabled),
                      style: _.findEmailValid.value
                          ? textButtonStyle
                          : textButtonStyleDisabled,
                    ),
                  ),
                ),
                Container(height: Get.height * 0.1),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 40),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextField(
                    onChanged: (value) {
                      controller.findPasswordButtonValidator();
                    },
                    controller: controller.emailController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "이메일 입력",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.065,
                  child: GetBuilder<AuthForgetController>(
                    init: controller,
                    builder: (_) => TextButton(
                      onPressed: _.findPasswordValid.value? () {
                        _.getResetPassword(_.emailController.text);
                      }:null,
                      child: Text("확인",
                          style: _.findPasswordValid.value
                              ? inTextButton
                              : inTextButtonDisabled),
                      style: _.findPasswordValid.value
                          ? textButtonStyle
                          : textButtonStyleDisabled,
                    ),
                  ),
                ),
                Container(height: Get.height * 0.1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
