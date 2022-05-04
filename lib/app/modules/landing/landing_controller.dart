import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class LandingController extends GetxController {
  final MyRepository repository;
  LandingController({required this.repository}) : assert(repository != null);

  getRefresh() async {
    await repository.getRefresh().then((refresh_result) async {
      Get.offAllNamed(refresh_result);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
