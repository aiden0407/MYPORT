import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_controller.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_view.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_view.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Get.height*0.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.01,
                      0.7,
                    ],
                    colors: [Color(0xffA9CBFF), Color(0xffFFFFFF)],
                  ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 100, left: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff44CFAE)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 28,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: mpBL,
                              ),
                              child: Center(child: Text("NOW", style: semibold_fFF_16)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 6),
                        child: Text("나와 같은 전공 사람들은?", style: bold_f33_24),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 6),
                        child: Text("지금 이런 활동을 하고 있어요", style: normal_f33_16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff5849ff)
                              ),
                              //child: Image.asset('assets/images/auth_1.png')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110,left: 24),
                            child: Container(
                              height: 37,
                              width: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: fFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Center(child: Text("NAME", style: semibold_f00_16)),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff44cfb2)
                              ),
                              //child: Image.asset('assets/images/auth_1.png')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110,left: 24),
                            child: Container(
                              height: 37,
                              width: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: fFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Center(child: Text("NAME", style: semibold_f00_16)),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mpBL
                              ),
                              //child: Image.asset('assets/images/auth_1.png')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110,left: 24),
                            child: Container(
                              height: 37,
                              width: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: fFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Center(child: Text("NAME", style: semibold_f00_16)),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffffb300)
                              ),
                              //child: Image.asset('assets/images/auth_1.png')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110,left: 24),
                            child: Container(
                              height: 37,
                              width: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: fFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Center(child: Text("NAME", style: semibold_f00_16)),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffed006b)
                              ),
                              //child: Image.asset('assets/images/auth_1.png')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110,left: 24),
                            child: Container(
                              height: 37,
                              width: 84,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: fFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Center(child: Text("NAME", style: semibold_f00_16)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 24)
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 40, left: 40, right: 40),
                      //   child: GestureDetector(
                      //     onTap: (){
                      //
                      //     },
                      //     child: Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: fF4,
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.grey.withOpacity(0.1),
                      //               spreadRadius: 1,
                      //               blurRadius: 3,
                      //               offset: Offset(2,2)
                      //             ),
                      //           ]
                      //       ),
                      //       child: Icon(Icons.refresh_rounded, color: mpBL.withOpacity(0.8), size: 30)
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: f245),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 20, left: Get.width*0.06, right: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("지금 참여 가능한\n공모전에 도전해 봐요", style: bold_f33_24),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: (){RootController.to.changeRootPageIndex(2);},
                              child: Icon(Icons.navigate_next, color: f44, size: 30),
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      GetBuilder<HomeController>(
                          init: controller,
                          builder: (_) =>
                              GestureDetector(
                                onTap: () {
                                  Get.find<ContestDetailController>().onInit();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      ContestDetailView(
                                        category: '공모전',
                                        ID: _.contest[_.refreshPage*3]['_id'],
                                      ),
                                  ));
                                },
                                child: _.contest==[] || _.contest.length<1
                                    ?Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 120,
                                  ),
                                )
                                :ContestListTile(
                                    dday: _.contest[_.refreshPage*3]['dday'],
                                    title: _.contest[_.refreshPage*3]['title'],
                                    founder: "founder API not exist",
                                    thumbnail: Image.network(
                                      _.contest[_.refreshPage*3]['image_url_thumbnail'],
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center();
                                      },
                                    ),
                                    relation_category: _.contest[_.refreshPage*3]['relation_category']
                                ),
                              )
                      ),
                      Divider(thickness: 1, color: feff),
                      GetBuilder<HomeController>(
                          init: controller,
                          builder: (_) =>
                              GestureDetector(
                                onTap: () {
                                  Get.find<ContestDetailController>().onInit();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      ContestDetailView(
                                        category: '공모전',
                                        ID: _.contest[_.refreshPage*3+1]['_id'],
                                      ),
                                  ));
                                },
                                child: _.contest==[] || _.contest.length<2
                                    ?Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 120,
                                  ),
                                )
                                    :ContestListTile(
                                    dday: _.contest[_.refreshPage*3+1]['dday'],
                                    title: _.contest[_.refreshPage*3+1]['title'],
                                    founder: "founder API not exist",
                                    thumbnail: Image.network(
                                      _.contest[_.refreshPage*3+1]['image_url_thumbnail'],
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center();
                                      },
                                    ),
                                    relation_category: _.contest[_.refreshPage*3]['relation_category']
                                ),
                              )
                      ),
                      Divider(thickness: 1, color: feff),
                      GetBuilder<HomeController>(
                          init: controller,
                          builder: (_) =>
                              GestureDetector(
                                onTap: () {
                                  Get.find<ContestDetailController>().onInit();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      ContestDetailView(
                                        category: '공모전',
                                        ID: _.contest[_.refreshPage*3+2]['_id'],
                                      ),
                                  ));
                                },
                                child: _.contest==[] || _.contest.length<3
                                    ?Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 120,
                                  ),
                                )
                                    :ContestListTile(
                                    dday: _.contest[_.refreshPage*3+2]['dday'],
                                    title: _.contest[_.refreshPage*3+2]['title'],
                                    founder: "founder API not exist",
                                    thumbnail: Image.network(
                                      _.contest[_.refreshPage*3+2]['image_url_thumbnail'],
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center();
                                      },
                                    ),
                                    relation_category: _.contest[_.refreshPage*3]['relation_category']
                                ),
                              )
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 80, left: Get.width*0.06, right: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("혼자가 어렵다면\n같이 도전해요", style: bold_f33_24),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: (){RootController.to.changeRootPageIndex(1);},
                            child: Icon(Icons.navigate_next, color: f44, size: 30),
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      GetBuilder<HomeController>(
                          init: controller,
                          builder: (_) => GestureDetector(
                        onTap: () {
                          Get.find<TeamDetailController>().onInit();
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              TeamDetailView(
                                isLeader: false,
                                isMember: false,
                                ID: _.team[_.refreshPage*3]['_id'],
                              ),
                          ));
                        },
                        child: _.team==[] || _.team.length<1
                            ?Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Container(
                            color: Colors.transparent,
                            height: 120,
                          ),
                        ):TeamListTile(
                            iconColor: mpBL,
                            memberInfo: "모집중",
                            textStyle: semibold_mpBL_14,
                            last: true,
                            count: _.team[_.refreshPage*3]['team_members'].length+1,
                            title: _.team[_.refreshPage*3]['team_name'],
                            relation_category: _.team[_.refreshPage*3]['relation_contest']==""
                                ?_.team[_.refreshPage*3]['relation_extracurricular']==""
                                ?_.team[_.refreshPage*3]['team_type']
                                :_.team[_.refreshPage*3]['relation_extracurricular']['title']
                                :_.team[_.refreshPage*3]['relation_contest']['title'],
                            thumbnail: _.team[_.refreshPage*3]['relation_contest']==""
                                ?_.team[_.refreshPage*3]['relation_extracurricular']==""
                                ? Container(
                              width: 88,
                              height: 120,
                              color: fDD,
                              child: Center(
                                child: Icon(Icons.image_not_supported, color: fCC,),
                              ),
                            )
                                :Image.network(_.team[_.refreshPage*3]['relation_extracurricular']['image_url_thumbnail'],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center();
                              },
                            )
                                :Image.network(_.team[_.refreshPage*3]['relation_contest']['image_url_thumbnail'],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center();
                              },
                            )

                        ),
                      )),
                      Divider(thickness: 1, color: feff),
                      GetBuilder<HomeController>(
                          init: controller,
                          builder: (_) =>GestureDetector(
                            onTap: () {
                              Get.find<TeamDetailController>().onInit();
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  TeamDetailView(
                                    isLeader: false,
                                    isMember: false,
                                    ID: _.team[_.refreshPage*3+1]['_id'],
                                  ),
                              ));
                            },
                            child: _.team==[] || _.team.length<2
                                ?Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                color: Colors.transparent,
                                height: 120,
                              ),
                            ):TeamListTile(
                                iconColor: mpBL,
                                memberInfo: "모집중",
                                textStyle: semibold_mpBL_14,
                                last: true,
                                count: _.team[_.refreshPage*3+1]['team_members'].length+1,
                                title: _.team[_.refreshPage*3+1]['team_name'],
                                relation_category: _.team[_.refreshPage*3+1]['relation_contest']==""
                                    ?_.team[_.refreshPage*3+1]['relation_extracurricular']==""
                                    ?_.team[_.refreshPage*3+1]['team_type']
                                    :_.team[_.refreshPage*3+1]['relation_extracurricular']['title']
                                    :_.team[_.refreshPage*3+1]['relation_contest']['title'],
                                thumbnail: _.team[_.refreshPage*3+1]['relation_contest']==""
                                    ?_.team[_.refreshPage*3+1]['relation_extracurricular']==""
                                    ? Container(
                                  width: 88,
                                  height: 120,
                                  color: fDD,
                                  child: Center(
                                    child: Icon(Icons.image_not_supported, color: fCC,),
                                  ),
                                )
                                    :Image.network(_.team[_.refreshPage*3+1]['relation_extracurricular']['image_url_thumbnail'],
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center();
                                  },
                                )
                                    :Image.network(_.team[_.refreshPage*3+1]['relation_contest']['image_url_thumbnail'],
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center();
                                  },
                                )

                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 80, left: Get.width*0.06, right: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NAME 님께 추천하는\n지식 공유 컨퍼런스", style: bold_f33_24),
                      SizedBox(height: 30),
                      GestureDetector(
                          onTap: () {
                            //RootController.to.changeRootPageIndex(2);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => ContestReadyView(category: '네이버 디자인 콜로키움',)));
                          },
                        child: Container(
                          height: 130,
                          child: Center(child: Image.asset('assets/images/example/home_1.png'))
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 60, left: Get.width*0.06, right: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("마이포트 해커톤에\n도전해 보세요!", style: bold_f33_24),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          //RootController.to.changeRootPageIndex(2);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => ContestReadyView(category: '마이포트 해커톤',)));
                        },
                        child: Container(
                            height: 355,
                            child: Center(child: Image.asset('assets/images/example/home_2.png'))
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 60, left: Get.width*0.06, right: Get.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("지금 포트폴리오 완성하면\n팀원 추천에 노출돼요!", style: bold_f33_24),
                      SizedBox(height: 30),
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: feff,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24),
                              Text("포트폴리오 완성률", style: normal_f33_16),
                              SizedBox(height: 19),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.0),
                                    child: Container(
                                      height: 10,
                                      width: 280,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: fFF
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.0),
                                    child: Container(
                                      height: 10,
                                      width: 2.8 * controller.portfolioPercentage.toDouble(),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: mpBL,
                                          gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            stops: [
                                              0.01,
                                              1,
                                            ],
                                            colors: [mpBL, Color(0xffA9CBFF)],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.47 * controller.portfolioPercentage.toDouble()),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: mpBL,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(controller.portfolioPercentage.toString()+'%', style: semibold_mpBL_16)
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                          width: Get.width * 0.88,
                          height: 55,
                          child: TextButton(
                              onPressed: () {
                                RootController.to.changeRootPageIndex(3);
                              },
                              child: Text("포트폴리오 완성하기", style: semibold_fFF_16),
                              style: textButtonStyle)),
                      SizedBox(height: 48),

                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}