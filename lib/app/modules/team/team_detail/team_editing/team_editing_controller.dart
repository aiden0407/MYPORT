import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_controller.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class TeamEditingController extends GetxController {
  final MyRepository repository;
  TeamEditingController({required this.repository}) : assert(repository != null);

  var teamId;
  var teamDetailData;

  getTeamDetail(ID) async {
    await repository.getTeamDetail(ID).then((data) {
      teamId = ID;
      teamDetailData = data;
      teamNameController.text = teamDetailData['team_name'];
      simpleExplainController.text = teamDetailData['short_explanation'];
      complicateExplainController.text = teamDetailData['detail_explanation'];
      recruitCategoryController.text = teamDetailData['recruitment_field'];
      imageController.text = '';
    });
    update();
  }

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

  TeamEditing(context, type) async{
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
    await repository.putTeamEdit(teamId, type, body).then((result) async {
      if(result) {
        Get.find<TeamDetailController>().onInit();
        Get.back();
        simpleDialog(100, "팀이 성공적으로 수정되었습니다");
        //RootController.to.willPopAction().then((value) => simpleDialog(100, "팀이 성공적으로 생성되었습니다"));
      } else {
        simpleDialog(100, "다시 시도해주세요");
      }
    });
  }

  @override
  void onInit() {
    teamDetailData = null;
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
