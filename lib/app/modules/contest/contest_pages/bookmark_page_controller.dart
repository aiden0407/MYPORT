import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class BookmarkPageController extends GetxController {
  final MyRepository repository;
  BookmarkPageController({required this.repository}) : assert(repository != null);

  String a = "북마크";

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
