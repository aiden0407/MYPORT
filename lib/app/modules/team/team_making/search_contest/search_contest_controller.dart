import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class SearchContestController extends GetxController {
  final MyRepository repository;
  SearchContestController({required this.repository}) : assert(repository != null);

  String a = "SearchContest";

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
