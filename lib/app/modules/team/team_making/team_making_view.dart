import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_making/search_contest/search_contest_view.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/team/team_making/team_making_controller.dart';
import 'package:image_picker/image_picker.dart';

class TeamMakingView extends GetView<TeamMakingController> {
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.image = File(pickedFile.path);
      controller.imagePath = pickedFile.path;
      controller.imageController.text = controller.imagePath.replaceAll('/data/user/0/com.example.folio/cache/', '');
      controller.update();
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.navigate_before, size: 28, color: Colors.black),
          onPressed: () {
            RootController.to.willPopAction();
          },
        ),
        title: Text("팀원 모집하기", style: semibold_f00_18),
        actions: [
          IconButton(
            icon: Icon(Icons.close_sharp, size: 24, color: Colors.black),
            onPressed: () {
              RootController.to.willPopAction();
            },
          ),
        ],
      ),
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.06, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text("어떤 종류의 팀인가요?", style: normal_f00_16),
                    ),
                    GetBuilder<TeamMakingController>(
                      init: controller,
                      builder: (_) => Wrap(
                        spacing: 8,
                        runSpacing: 2,
                        children: [
                          buildFilterChip(_, 0),
                          buildFilterChip(_, 1),
                          buildFilterChip(_, 2),
                          buildFilterChip(_, 3),
                          buildFilterChip(_, 4),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("팀 이름", style: normal_f00_16),
                    ),
                    SizedBox(
                      height: 54,
                      child: TextField(
                        decoration: buildInputDecoration('팀 이름'),
                        controller: controller.teamNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("간단한 설명", style: normal_f00_16),
                    ),
                    SizedBox(
                      height: 54,
                      child: TextField(
                        decoration: buildInputDecoration('간단한 팀 설명을 작성해주세요 (최대 20자)'),
                        inputFormatters: [ LengthLimitingTextInputFormatter(20) ],
                        controller: controller.simpleExplainController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("자세한 설명", style: normal_f00_16),
                    ),
                    SizedBox(
                      height: 160,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 7,
                        maxLines: null,
                        decoration: buildInputDecoration('자세한 팀 설명을 작성해주세요'),
                        controller: controller.complicateExplainController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("모집 분야", style: normal_f00_16),
                    ),
                    SizedBox(
                      height: 160,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 7,
                        maxLines: null,
                        decoration: buildInputDecoration('모집 중인 분야에 대해서 작성해 주세요'),
                        controller: controller.recruitCategoryController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("연관된 공모전", style: normal_f00_16),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 54,
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search, color: fAA),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: f245, width: 0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: '검색',
                              hintStyle: normal_fBB_16,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: f245,
                                ),
                              ),
                              filled: true,
                              fillColor: f245,
                            ),
                            inputFormatters: [ LengthLimitingTextInputFormatter(20) ],
                            controller: controller.relatedContestController,
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SearchContestView(
                                    fromMaking: true,
                                  )));
                            },
                            child: Container(height: 54, color: Colors.transparent))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text("모집공고 이미지", style: normal_f00_16),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 54,
                          child: TextField(
                            style: TextStyle(fontSize: 14),
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.image_outlined, color: fAA),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: f245, width: 0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: '선택',
                              hintStyle: normal_fBB_16,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: f245,
                                ),
                              ),
                              filled: true,
                              fillColor: f245,
                            ),
                            inputFormatters: [ LengthLimitingTextInputFormatter(20) ],
                            controller: controller.imageController,
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              getImage();
                            },
                            child: Container(height: 54, color: Colors.transparent))
                      ],
                    ),
                  ],
                ),
              ),
              //Divider(thickness: 8, color: f245),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: Get.width*0.06, vertical: 15),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(16.0)
                    //         ),
                    //         useRootNavigator: true,
                    //         context: context,
                    //         builder: (BuildContext context){
                    //           return Container(
                    //             padding: EdgeInsets.only(top: 20,left: Get.width * 0.07, right: Get.width * 0.07),
                    //             height: 190,
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.only(
                    //                   topLeft: const Radius.circular(16.0),
                    //                   topRight: const Radius.circular(16.0),
                    //                 ),
                    //                 color: Colors.white
                    //             ),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text("성별", style: semibold_f33_18),
                    //                 SizedBox(height: 5),
                    //                 GetBuilder<TeamMakingController>(
                    //                   init: controller,
                    //                   builder: (_) => Wrap(
                    //                     spacing: 6,
                    //                     children: [
                    //                       buildGenderFilterChip(_, 0),
                    //                       buildGenderFilterChip(_, 1),
                    //                       buildGenderFilterChip(_, 2),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(child: Container()),
                    //                 Column(
                    //                   children: [
                    //                     SizedBox(
                    //                       width: Get.width * 0.86,
                    //                       height: 50,
                    //                       child: TextButton(
                    //                         onPressed: (){
                    //                           Navigator.pop(context);
                    //                         },
                    //                         child: Text("확인", style: inTextButton),
                    //                         style: textButtonStyle,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 SizedBox(height: 40)
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Text("성별", style: normal_f00_16),
                    //       Expanded(child: Container()),
                    //       GetBuilder<TeamMakingController>(
                    //           init: controller,
                    //           builder: (_) => Text(_.gender, style: normal_f66_16)
                    //       ),
                    //       Icon(Icons.navigate_next, color: f44, size: 30),
                    //     ],
                    //   ),
                    // ),
                    //SizedBox(height: 40),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.86,
                          height: 50,
                          child: TextButton(
                            onPressed: (){
                              if (controller.teamType == '공모전/해커톤' && controller.relatedContest!=''){
                                print("case: 1");
                                controller.TeamMaking(context, 1);
                              } else if (controller.teamType == '대외활동' && controller.relatedOutdoor!=''){
                                print("case: 2");
                                controller.TeamMaking(context, 2);
                              } else {
                                print("case: 0");
                                controller.TeamMaking(context, 0);
                              }
                            },
                            child: Text("생성하기", style: inTextButton),
                            style: textButtonStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FilterChip buildFilterChip(TeamMakingController _, int index) {
    return FilterChip(
      label: Text(_.labels[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  _.selected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.selected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.selected[index],
      onSelected: (bool value) {
        _.onSelect(index);
      },
    );
  }

  FilterChip buildGenderFilterChip(TeamMakingController _, int index) {
    return FilterChip(
      label: Text(_.genderList[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
              _.genderSelected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 19),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.genderSelected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.genderSelected[index],
      onSelected: (bool value) {
        _.genderOnSelect(index);
      },
    );
  }
}
