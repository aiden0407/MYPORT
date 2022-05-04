import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class PortfolioController extends GetxController {
  final MyRepository repository;
  PortfolioController({required this.repository}) : assert(repository != null);

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
}
