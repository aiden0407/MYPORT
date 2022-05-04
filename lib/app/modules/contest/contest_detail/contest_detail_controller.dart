import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class ContestDetailController extends GetxController {
  final MyRepository repository;
  ContestDetailController({required this.repository}) : assert(repository != null);

  var leftDate;

  var contestDetailData;
  getContestDetail(ID) async {
    await repository.getContestDetail(ID).then((data) {
      contestDetailData = data;
      var date = DateTime.parse(contestDetailData["end_date"]+" 24:00:00");
      final now = DateTime.now();
      final difference = date.difference(now);
      leftDate = (difference.inHours/24).floor().toString()+"일 "+(difference.inHours % 24).toString()+":00:00";
    });
    update();
  }
  postContestBookmark(ID) async {
    await repository.postContestBookmark(ID).then((data) {
      data? simpleDialog(100, "스크랩에 추가되었습니다")
      : simpleDialog(100, "이미 스크랩에 추가되어 있습니다");
    });
  }


  var outdoorDetailData;
  getOutdoorDetail(ID) async {
    await repository.getOutdoorDetail(ID).then((data) {
      outdoorDetailData = data;
      var date = DateTime.parse(outdoorDetailData["end_date"]+" 24:00:00");
      final now = DateTime.now();
      final difference = date.difference(now);
      leftDate = (difference.inHours/24).floor().toString()+"일 "+(difference.inHours % 24).toString()+":00:00";
    });
    update();
  }
  postOutdoorBookmark(ID) async {
    await repository.postOutdoorBookmark(ID).then((data) {
      data? simpleDialog(100, "스크랩에 추가되었습니다")
          : simpleDialog(100, "이미 스크랩에 추가되어 있습니다");
    });
  }

  @override
  void onInit() {
    contestDetailData=null;
    outdoorDetailData=null;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
