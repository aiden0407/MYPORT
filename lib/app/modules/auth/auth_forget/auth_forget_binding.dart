import 'package:get/get.dart';
import 'package:folio/app/modules/auth/auth_forget/auth_forget_controller.dart';

class AuthForgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthForgetController>(AuthForgetController());
  }
}
