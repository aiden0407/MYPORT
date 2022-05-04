import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_editing/team_editing_view.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_controller.dart';

class TeamDetailView extends GetView<TeamDetailController> {
  final bool isLeader;
  final bool isMember;
  final String ID;

  TeamDetailView({
    required this.isLeader,
    required this.isMember,
    required this.ID
  });

  @override
  Widget build(BuildContext context) {
    controller.getTeamDetail(ID);
    isLeader?controller.initTabController(3):controller.initTabController(2);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mpBL,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.navigate_before, size: 20, color: fFF),
            onPressed: () {
              Get.find<TeamController>().onInit();
              RootController.to.willPopAction();
            },
          ),
          actions: [
            isLeader
            ?IconButton(
              icon: Icon(Icons.more_vert, size: 20, color: fFF),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    useRootNavigator: true,
                    context: context,
                    builder: (BuildContext context){
                      return Container(
                        padding: EdgeInsets.only(top: 32,left: Get.width * 0.07, right: Get.width * 0.07),
                        height: 270,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16.0),
                              topRight: const Radius.circular(16.0),
                            ),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("더보기", style: semibold_f33_18),
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => TeamEditingView(
                                      ID: ID,
                                    )));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.article_outlined),
                                  Text("  상세정보 수정", style: semibold_f33_16),
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20, bottom: 5),
                                      height: 140,
                                      width: 70,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text("팀 해체", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                                            SizedBox(height: 10),
                                            Text("팀을 해체하시겠습니까?", style: TextStyle(fontSize: 14)),
                                            Expanded(child: Container()),
                                            Divider(),
                                            TextButton(
                                              onPressed: () async {
                                                Get.back();
                                                controller.deleteTeam(ID);
                                              },
                                              child: Text("확인"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.dnd_forwardslash),
                                  Text("  팀 해체하기", style: semibold_f33_16),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Column(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.86,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      controller.patchTeamEditRecruit(ID);
                                      controller.onInit();
                                      controller.getTeamDetail(ID);
                                    },
                                    child: GetBuilder<TeamDetailController>(
                                        init: controller,
                                        builder: (_) => _.teamDetailData['recruiting']
                                            ?Text("팀원 모집 마감하기", style: inTextButton)
                                            :Text("팀원 모집하기", style: inTextButton)
                                    ),
                                    style: textButtonStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40)
                          ],
                        ),
                      );
                    });
              },
            )
            :isMember
            ?IconButton(
              icon: Icon(Icons.more_vert, size: 20, color: fFF),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    useRootNavigator: true,
                    context: context,
                    builder: (BuildContext context){
                      return Container(
                        padding: EdgeInsets.only(top: 32,left: Get.width * 0.07, right: Get.width * 0.07),
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16.0),
                              topRight: const Radius.circular(16.0),
                            ),
                            color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("더보기", style: semibold_f33_18),
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20, bottom: 5),
                                      height: 140,
                                      width: 70,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text("팀 탈퇴", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                                            SizedBox(height: 10),
                                            Text("팀에서 탈퇴하시겠습니까?", style: TextStyle(fontSize: 14)),
                                            Expanded(child: Container()),
                                            Divider(),
                                            TextButton(
                                              onPressed: () async {
                                                Get.back();
                                                controller.deleteTeamLeave(ID);
                                              },
                                              child: Text("확인"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app),
                                  Text("  팀 탈퇴하기", style: semibold_f33_16),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      );
                    });
              },
            )
            :Container()
          ],
        ),
      body: GetBuilder<TeamDetailController>(
        init: controller,
        builder: (_) {
          if(isLeader){
            return _.teamDetailData==null
                ?Container()
                :Column(
                  children: [
                    Container(
                      width: Get.width,
                      color: mpBL,
                      padding: EdgeInsets.only(top:10, bottom: 30, left: Get.width*0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_.teamDetailData["team_name"], style: bold_fFF_20),
                          SizedBox(height: 7),
                          Text(_.teamDetailData["short_explanation"], style: normal_fFF_14),
                        ],
                      ),
                    ),
                    TabBar(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        indicatorColor: mpBL,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: semibold_f00_16,
                        labelColor: Colors.black,
                        unselectedLabelColor: fAA,
                        controller: controller.tabController,
                        tabs: [
                          Tab(text: "상세정보"),
                          Tab(text: "팀 정보"),
                          Tab(text: "지원 대기"),
                        ]
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("팀 설명", style: bold_f00_18),
                                    SizedBox(height: 12),
                                    Text(_.teamDetailData['detail_explanation']),
                                    SizedBox(height: 24),
                                    Text("모집 분야", style: bold_f00_18),
                                    SizedBox(height: 12),
                                    Text(_.teamDetailData['recruitment_field']),
                                  ],
                                )
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.all(24),
                                child: Container(
                                  height: 500,
                                  color: feff,
                                  child: Text(_.memberList.toString()),
                                )
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.all(24),
                                child: Container(
                                  height: 900,
                                  color: feff,
                                  child: Text(_.teamDetailData['waiting_for_support'].toString()),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
          } else {
            return _.teamDetailData==null
                ?Container()
                :Column(
              children: [
                Container(
                  width: Get.width,
                  color: mpBL,
                  padding: EdgeInsets.only(top:10, bottom: 30, left: Get.width*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_.teamDetailData["team_name"], style: bold_fFF_20),
                      SizedBox(height: 7),
                      Text(_.teamDetailData["short_explanation"], style: normal_fFF_14),
                    ],
                  ),
                ),
                TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    indicatorColor: mpBL,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: semibold_f00_16,
                    labelColor: Colors.black,
                    unselectedLabelColor: fAA,
                    controller: controller.tabController,
                    tabs: [
                      Tab(text: "상세정보"),
                      Tab(text: "팀 정보"),
                    ]
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("팀 설명", style: bold_f00_18),
                                SizedBox(height: 12),
                                Text(_.teamDetailData['detail_explanation']),
                                SizedBox(height: 24),
                                Text("모집 분야", style: bold_f00_18),
                                SizedBox(height: 12),
                                Text(_.teamDetailData['recruitment_field']),
                              ],
                            )
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(24),
                            child: Container(
                              height: 300,
                              color: feff,
                              child: Text("mem"),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        })
    );
  }
}