import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_controller.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class TeamDetailController extends GetxController with GetTickerProviderStateMixin  {
  final MyRepository repository;
  TeamDetailController({required this.repository}) : assert(repository != null);

  late TabController tabController;
  initTabController(int length){
    tabController = TabController(vsync: this, length: length);
  }

  var teamDetailData;
  var memberList;

  getTeamDetail(ID) async {
    await repository.getTeamDetail(ID).then((data) {
      teamDetailData = data;
      int memberLines=0;
      memberLines = (teamDetailData['team_members'].length/3 + 1).toInt();
      var twoDList=[];
      for(int i=0; i<memberLines; i++ ){
        twoDList.add([]);
        if(teamDetailData['team_members'].length-i*3>3){
          for(int j=0; j<3; j++ ){
            if(i==0&&j==0) twoDList[i].add(teamDetailData['team_leader']);
            else if (teamDetailData['team_members'][i*3+j-1]!=null)
              twoDList[i].add(teamDetailData['team_members'][i*3+j-1]);
          }
        } else {
          for(int j=0; j<(teamDetailData['team_members'].length-i*3)%3+1; j++ ){
            if(i==0&&j==0) twoDList[i].add(teamDetailData['team_leader']);
            else if (teamDetailData['team_members'][i*3+j-1]!=null)
              twoDList[i].add(teamDetailData['team_members'][i*3+j-1]);
          }
        }
      }
      memberList = twoDList;
    });
    update();
  }


  deleteTeam(ID) async {
    await repository.deleteTeam(ID).then((data) {
      if(data) {
        Get.find<TeamController>().onInit();
        RootController.to.willPopAction().then((value) => simpleDialog(100, "팀이 성공적으로 해체되었습니다"));
      } else {
        simpleDialog(100, "다시 시도해주세요");
      }
    });
    update();
  }
  patchTeamEditRecruit(ID) async {
    await repository.patchTeamEditRecruit(ID).then((data) {
      if(data){
        simpleDialog(100, "팀 모집 상태가 변경되었습니다");
      }else{
        simpleDialog(100, "다시 시도해주세요");
      }
    });
    update();
  }
  deleteTeamLeave(ID) async {
    await repository.deleteTeamLeave(ID).then((data) {
      if(data){
        onInit();
        getTeamDetail(ID);
        Get.find<TeamController>().onInit();
        simpleDialog(100, "팀 탈퇴가 완료되었습니다");
      }else{
        simpleDialog(100, "다시 시도해주세요");
      }
    });
    update();
  }

  @override
  void onInit() {
    teamDetailData=null;
    memberList=null;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
