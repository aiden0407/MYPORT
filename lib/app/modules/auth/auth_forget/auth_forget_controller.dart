import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/data/provider/api_provider.dart';
import 'package:folio/app/data/repository/repository.dart';
import 'package:http/http.dart' as http;

class AuthForgetController extends GetxController with GetSingleTickerProviderStateMixin {
  final MyRepository repository = MyRepository(
    apiProvider: MyApiProvider(
      httpClient: http.Client(),
    ),
  );

  late TabController tabController;

  RxBool findEmailValid = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  void findEmailButtonValidator() {
    if (nameController.text.isNotEmpty &&
        birthController.text.length==6 &&
        int.parse(birthController.text.substring(2, 4)) > 0 &&
        int.parse(birthController.text.substring(2, 4)) <= 12 &&
        int.parse(birthController.text.substring(4)) > 0 &&
        int.parse(birthController.text.substring(4)) <= 31) {
      findEmailValid = true.obs;
    } else {
      findEmailValid = false.obs;
    }
    update();
  }
  getFindEmail(name, birth) async {
    await repository.getFindEmail(name, birth).then((result) {
      if(result=='email not exist'){
        simpleDialog(120, '해당 회원정보로 가입된 이메일을 찾을 수 없습니다.\n다시 한번 확인해 주시기 바랍니다.');
      } else if (result=='server error') {
        simpleDialog(120, '서버 요청 에러입니다.\n다시 시도해 주시기 바랍니다.');
      } else {
        simpleDialog(120, name+' 님이 가입하신 이메일은\n'+result+' 입니다.');
      }
    });
  }

  RxBool findPasswordValid = false.obs;
  TextEditingController emailController = TextEditingController();
  void findPasswordButtonValidator() {
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)
        ?findPasswordValid = true.obs
        :findPasswordValid = false.obs;
    update();
  }
  getResetPassword(email) async {
    await repository.getResetPassword(email).then((result) {
      if(result==200){
        simpleDialog(120, '해당 이메일로 전송된\n메일을 확인하여 주시기 바랍니다.');
      } else if (result==400) {
        simpleDialog(100, '해당 이메일이 존재하지 않습니다.');
      } else {
        simpleDialog(120, '서버 요청 에러입니다.\n다시 시도해 주시기 바랍니다.');
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
