import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_view.dart';
import 'package:folio/app/modules/team/team_making/team_making_controller.dart';
import 'package:folio/app/modules/team/team_making/team_making_view.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/modules/team/team_controller.dart';

class TeamView extends GetView<TeamController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("팀 만들기", style: semibold_f00_18),
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<TeamMakingController>().onInit();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeamMakingView()));
            },
            child: Center(child: Text("모집하기", style: normal_mpBL_16)),
          ),
          SizedBox(width: 12)
        ],
      ),
      body: GetBuilder<TeamController>(
          init: controller,
          builder: (_) => Column(
            children: [
              Container(
                //color: mpBL,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: Get.width * 0.05),
                width: Get.width,
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: buildSearchInputDecoration('공모전명, 팀명을 검색해 보세요'),
                        controller: controller.searchController,
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)
                            ),
                            useRootNavigator: true,
                            context: context,
                            builder: (BuildContext context){
                          return Container(
                            padding: EdgeInsets.only(top: Get.height*0.03,left: Get.width * 0.07, right: Get.width * 0.07),
                            height: Get.height*0.35,
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
                                Text("분야", style: semibold_f33_18),
                                SizedBox(height: 15),
                                GetBuilder<TeamController>(
                                  init: controller,
                                  builder: (_) => Wrap(
                                    spacing: 6,
                                    runSpacing: 2,
                                    children: [
                                      FilterChip(
                                        label: Text(_.labels[0],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: _.selected[0]
                                                    ? Color(0xff428EFF)
                                                    : Color(0xff9B9B9B))),
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                              color: _.selected[0]
                                                  ? Color(0xff428EFF)
                                                  : Color(0xffEFF2FB),
                                              width: 1),
                                        ),
                                        backgroundColor: Colors.white,
                                        selectedColor: Color(0xffF1F7FF),
                                        showCheckmark: false,
                                        selected: _.selected[0],
                                        onSelected: (bool value) {
                                          _.selected[0] = value;
                                          _.update();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text(_.labels[1],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: _.selected[1]
                                                    ? Color(0xff428EFF)
                                                    : Color(0xff9B9B9B))),
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                              color: _.selected[1]
                                                  ? Color(0xff428EFF)
                                                  : Color(0xffEFF2FB),
                                              width: 1),
                                        ),
                                        backgroundColor: Colors.white,
                                        selectedColor: Color(0xffF1F7FF),
                                        showCheckmark: false,
                                        selected: _.selected[1],
                                        onSelected: (bool value) {
                                          _.selected[1] = value;
                                          _.update();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text(_.labels[2],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: _.selected[2]
                                                    ? Color(0xff428EFF)
                                                    : Color(0xff9B9B9B))),
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                              color: _.selected[2]
                                                  ? Color(0xff428EFF)
                                                  : Color(0xffEFF2FB),
                                              width: 1),
                                        ),
                                        backgroundColor: Colors.white,
                                        selectedColor: Color(0xffF1F7FF),
                                        showCheckmark: false,
                                        selected: _.selected[2],
                                        onSelected: (bool value) {
                                          _.selected[2] = value;
                                          _.update();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text(_.labels[3],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: _.selected[3]
                                                    ? Color(0xff428EFF)
                                                    : Color(0xff9B9B9B))),
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                              color: _.selected[3]
                                                  ? Color(0xff428EFF)
                                                  : Color(0xffEFF2FB),
                                              width: 1),
                                        ),
                                        backgroundColor: Colors.white,
                                        selectedColor: Color(0xffF1F7FF),
                                        showCheckmark: false,
                                        selected: _.selected[3],
                                        onSelected: (bool value) {
                                          _.selected[3] = value;
                                          _.update();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text(_.labels[4],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: _.selected[4]
                                                    ? Color(0xff428EFF)
                                                    : Color(0xff9B9B9B))),
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                        shape: BeveledRectangleBorder(
                                          side: BorderSide(
                                              color: _.selected[4]
                                                  ? Color(0xff428EFF)
                                                  : Color(0xffEFF2FB),
                                              width: 1),
                                        ),
                                        backgroundColor: Colors.white,
                                        selectedColor: Color(0xffF1F7FF),
                                        showCheckmark: false,
                                        selected: _.selected[4],
                                        onSelected: (bool value) {
                                          _.selected[4] = value;
                                          _.update();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.86,
                                      height: Get.height * 0.065,
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text("적용", style: inTextButton),
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
                      child: Icon(Icons.tune_rounded, size: 30, color: fCC),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GetBuilder<TeamController>(
                      init: controller,
                      builder: (_) => Column(
                      children: [
                        _.leader.length==0 && _.member.length==0
                        ?Container()
                        :Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: Get.width * 0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("내가 소속된 팀", style: bold_f00_18),
                                  _.leader.length==0
                                      ?Container()
                                      :ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        _.leader.length,
                                            (index) =>
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<TeamDetailController>().onInit();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                    TeamDetailView(
                                                      isLeader: true,
                                                      isMember: false,
                                                      ID: _.leader[index]['_id'],
                                                    ),
                                                ));
                                              },
                                              child: TeamListTile(
                                                  iconColor: mpGR,
                                                  memberInfo: "팀장",
                                                  textStyle: semibold_mpGR_14,
                                                  last: index==_.leader.length-1,
                                                  count: _.leader[index]['team_members']==null
                                                      ?1
                                                  :_.leader[index]['team_members'].length+1,
                                                  title: _.leader[index]['team_name'],
                                                  relation_category: _.leader[index]['relation_contest']==""
                                                      ?_.leader[index]['relation_extracurricular']==""
                                                          ? _.leader[index]['team_type']
                                                          :_.leader[index]['relation_extracurricular']['title']
                                                      :_.leader[index]['relation_contest']['title'],
                                                  thumbnail: _.leader[index]['relation_contest']==""
                                                      ?_.leader[index]['relation_extracurricular']==""
                                                          ?_.leader[index]['team_image_url']==""
                                                  ?Container(
                                                    width: 88,
                                                    height: 120,
                                                    color: fDD,
                                                    child: Center(
                                                      child: Icon(Icons.image_not_supported, color: fCC,),
                                                    ),
                                                  )
                                                  :Image.network(_.leader[index]['team_image_url'],
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                          value: loadingProgress.expectedTotalBytes != null
                                                              ? loadingProgress.cumulativeBytesLoaded /
                                                              loadingProgress.expectedTotalBytes!
                                                              : null,
                                                          color: Colors.transparent,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                          :Image.network(_.leader[index]['relation_extracurricular']['image_url_thumbnail'],
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center();
                                                    },
                                                  )
                                                      :Image.network(_.leader[index]['relation_contest']['image_url_thumbnail'],
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center();
                                                    },
                                                  )

                                                  ),
                                            ),)),
                                  _.leader.length==0 || _.member.length==0
                                      ?Container()
                                      :Divider(thickness: 1, color: feff),
                                  _.member.length==0
                                      ?Container()
                                      :ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        _.member.length,
                                            (index) =>
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<TeamDetailController>().onInit();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                    TeamDetailView(
                                                      isLeader: false,
                                                      isMember: true,
                                                      ID: _.member[index]['_id'],
                                                    ),
                                                ));
                                              },
                                              child: TeamListTile(
                                                  iconColor: mpGR,
                                                  memberInfo: "팀원",
                                                  textStyle: semibold_mpGR_14,
                                                  last: index==_.member.length-1,
                                                  count: _.member[index]['team_members']==null
                                                      ?1
                                                      :_.member[index]['team_members'].length+1,
                                                  title: _.member[index]['team_name'],
                                                  relation_category: _.member[index]['relation_contest']==""
                                                      ?_.member[index]['relation_extracurricular']==""
                                                      ? _.member[index]['team_type']
                                                      :_.member[index]['relation_extracurricular']['title']
                                                      :_.member[index]['relation_contest']['title'],
                                                  thumbnail: _.member[index]['relation_contest']==""
                                                      ?_.member[index]['relation_extracurricular']==""
                                                      ? Container(
                                                    width: 88,
                                                    height: 120,
                                                    color: fDD,
                                                    child: Center(
                                                      child: Icon(Icons.image_not_supported, color: fCC,),
                                                    ),
                                                  )
                                                      :Image.network(_.member[index]['relation_extracurricular']['image_url_thumbnail'],
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center();
                                                    },
                                                  )
                                                      :Image.network(_.member[index]['relation_contest']['image_url_thumbnail'],
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Center();
                                                    },
                                                  )

                                              ),
                                            ),)),
                                ],
                              ),
                            ),
                            Divider(thickness: 8, color: f245),
                          ],
                        ),
                        _.waiting.length==0
                            ?Container()
                            :Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: Get.width * 0.06),
                                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  Text("내가 지원한 팀", style: bold_f00_18),
                                  ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  _.waiting.length,
                                      (index) =>
                                      GestureDetector(
                                        onTap: () {
                                          Get.find<TeamDetailController>().onInit();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              TeamDetailView(
                                                isLeader: false,
                                                isMember: false,
                                                ID: _.waiting[index]['_id'],
                                              ),
                                          ));
                                        },
                                        child: TeamListTile(
                                            iconColor: mpGR,
                                            memberInfo: "지원대기",
                                            textStyle: semibold_mpGR_14,
                                            last: index==_.waiting.length-1,
                                            count: _.waiting[index]['team_members']==null
                                                ?1
                                                :_.waiting[index]['team_members'].length+1,
                                            title: _.waiting[index]['team_name'],
                                            relation_category: _.waiting[index]['relation_contest']==""
                                                ?_.waiting[index]['relation_extracurricular']==""
                                                ? _.waiting[index]['team_type']
                                                :_.waiting[index]['relation_extracurricular']['title']
                                                :_.waiting[index]['relation_contest']['title'],
                                            thumbnail: _.waiting[index]['relation_contest']==""
                                                ?_.waiting[index]['relation_extracurricular']==""
                                                ? Container(
                                              width: 88,
                                              height: 120,
                                              color: fDD,
                                              child: Center(
                                                child: Icon(Icons.image_not_supported, color: fCC,),
                                              ),
                                            )
                                                :Image.network(_.waiting[index]['relation_extracurricular']['image_url_thumbnail'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center();
                                              },
                                            )
                                                :Image.network(_.waiting[index]['relation_contest']['image_url_thumbnail'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center();
                                              },
                                            )

                                        ),
                                      ),)),
                                     ],
                                   ),
                                ),
                                Divider(thickness: 8, color: f245),
                              ],
                            ),
                        _.normal==[]
                            ?Container()
                            :Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: Get.width * 0.06),
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text("팀원 모집 중인 글", style: bold_f00_18),
                            ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  _.normal.length,
                                      (index) =>
                                      GestureDetector(
                                        onTap: () {
                                          Get.find<TeamDetailController>().onInit();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              TeamDetailView(
                                                isLeader: false,
                                                isMember: false,
                                                ID: _.normal[index]['_id'],
                                              ),
                                          ));
                                        },
                                        child: TeamListTile(
                                            iconColor: _.normal[index]['recruiting']
                                                ?mpBL
                                                :f66,
                                            memberInfo: _.normal[index]['recruiting']
                                                ?"모집중"
                                                :"모집마감",
                                            textStyle: _.normal[index]['recruiting']
                                                ?semibold_mpBL_14
                                                :semibold_f66_14,
                                            last: index==_.normal.length-1,
                                            count: _.normal[index]['team_members']==null
                                                ?1
                                                :_.normal[index]['team_members'].length+1,
                                            title: _.normal[index]['team_name'],
                                            relation_category: _.normal[index]['relation_contest']==""
                                                ?_.normal[index]['relation_extracurricular']==""
                                                ? _.normal[index]['team_type']
                                                :_.normal[index]['relation_extracurricular']['title']
                                                :_.normal[index]['relation_contest']['title'],
                                            thumbnail: _.normal[index]['relation_contest']==""
                                                ?_.normal[index]['relation_extracurricular']==""
                                                ? Container(
                                              width: 88,
                                              height: 120,
                                              color: fDD,
                                              child: Center(
                                                child: Icon(Icons.image_not_supported, color: fCC,),
                                              ),
                                            )
                                                :Image.network(_.normal[index]['relation_extracurricular']['image_url_thumbnail'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center();
                                              },
                                            )
                                                :Image.network(_.normal[index]['relation_contest']['image_url_thumbnail'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center();
                                              },
                                            )

                                        ),
                                      ),))
                          ],
                        ),
                            ),
                      ],
                  ))
                )
              ),
            ],
          )
      ),
    );
  }
}
