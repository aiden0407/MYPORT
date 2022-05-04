import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_controller.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class TeamMakingController extends GetxController {
  final MyRepository repository;
  TeamMakingController({required this.repository}) : assert(repository != null);

  late TextEditingController teamNameController;
  late TextEditingController simpleExplainController;
  late TextEditingController complicateExplainController;
  late TextEditingController recruitCategoryController;
  late TextEditingController relatedContestController;
  late TextEditingController imageController;

  String relatedContest = '';
  String relatedContestID = '';
  String relatedOutdoor = '';
  String relatedOutdoorID = '';

  String teamType = '공모전/해커톤';
  List labels = [
    '공모전/해커톤',
    '스터디',
    '대외활동',
    '프로젝트',
    '기타'
  ];
  List selected = [
    true,
    false,
    false,
    false,
    false
  ];
  onSelect(index) {
    selected = [false, false, false, false, false];
    selected[index] = true;
    teamType = labels[index];
    update();
  }

  late File image;
  String imagePath='';

  double maximum = 20;
  setMaximum(double input) {
    maximum = input;
    update();
  }

  String gender = '제한 없음';
  List genderList = [
    '제한 없음',
    '남성 그룹',
    '여성 그룹',
  ];
  List genderSelected = [
    true,
    false,
    false
  ];
  genderOnSelect(index) {
    genderSelected = [false, false, false];
    genderSelected[index] = true;
    gender = genderList[index];
    update();
  }

  TeamMaking(context, type) async{
    var body = {
      "team_name" : teamNameController.text,
      "short_explanation" : simpleExplainController.text,
      "detail_explanation" : complicateExplainController.text,
      "recruitment_field" : recruitCategoryController.text,
      "team_type" : teamType,
      "gender" : gender,
      "relation_contest" : relatedContestID,
      "relation_extracurricular" : relatedOutdoorID,
      "image" : imagePath
    };
    await repository.postTeamMaking(type, body).then((result) async {
      if(result) {
        Get.find<TeamController>().onInit();
        RootController.to.willPopAction().then((value) => simpleDialog(100, "팀이 성공적으로 생성되었습니다"));
      } else {
        simpleDialog(100, "다시 시도해주세요");
      }
    });
  }

  @override
  void onInit() {
    teamNameController = TextEditingController();
    simpleExplainController = TextEditingController();
    complicateExplainController = TextEditingController();
    recruitCategoryController = TextEditingController();
    relatedContestController = TextEditingController();
    imageController = TextEditingController();
    gender = '제한 없음';
    selected = [
      true,
      false,
      false,
      false,
      false
    ];
    imagePath='';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
  }
}
