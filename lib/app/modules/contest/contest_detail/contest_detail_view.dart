import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/contest/contest_controller.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ContestDetailView extends GetView<ContestDetailController> {
  final String category;
  final String ID;

  ContestDetailView({
    required this.category,
    required this.ID
  });

  @override
  Widget build(BuildContext context) {
    if(category=='공모전'){
      controller.getContestDetail(ID);
    } else if (category=='대외활동'){
      controller.getOutdoorDetail(ID);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.navigate_before, size: 28, color: Colors.black),
          onPressed: () {
            Get.find<ContestController>().onInit();
            RootController.to.willPopAction();
          },
        ),
        title: Text('상세정보', style: semibold_f00_18),
        actions: [],
      ),
      body: GetBuilder<ContestDetailController>(
          init: controller,
          builder: (_) {
            if(category=='공모전'){
              return _.contestDetailData==null
                  ?Container()
                  :Stack(
                    children: [
                      SingleChildScrollView(
                         child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: Get.width,
                          child: Image.network(
                            _.contestDetailData['image_url_introduction'].replaceAll('https', 'http'),
                            fit: BoxFit.fitHeight,
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
                          ),
                        ),
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_.contestDetailData['title'], style: normal_f33_20),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 2.0),
                                      child: Text(
                                          _.contestDetailData['founder'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: normal_f66_14
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 2.0),
                                      child: Text(
                                        " | "+_.contestDetailData['awards'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: normal_fBB_14
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 32,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    _.contestDetailData['relation_category'].length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Container(
                                            height: 32,
                                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: f245,
                                            ),
                                            child: Text(
                                              _.contestDetailData['relation_category'][index]['interest_name'],
                                              style: normal_f66_13
                                            ),
                                          ),
                                        )
                                  )
                                ),
                              ),
                              SizedBox(height: 11),
                              Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: f17F,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today_outlined, color: mpBL, size: 18),
                                        SizedBox(width: 5),
                                        Text("남은기한", style: normal_mpBL_16),
                                      ],
                                    ),
                                    Text(_.leftDate, style: semibold_mpBL_16),
                                    Text(_.contestDetailData["end_date"].toString().substring(5,7)+"월 "
                                        + _.contestDetailData["end_date"].toString().substring(8,10)+"일까지", style: normal_fBB_14),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("지원 자격", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.contestDetailData["eligibility"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("공모 주제", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.contestDetailData["topic"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("상세 정보", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.contestDetailData["detail_information"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("상금", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.contestDetailData["awards"], style: normal_f33_16),
                              SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
                      Positioned.fill(
                        bottom: 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: Get.width * 0.4,
                                  height: 52,
                                  child: TextButton(
                                      onPressed: () {
                                        Get.find<ContestController>().onInit();
                                        _.postContestBookmark(_.contestDetailData['id']);
                                      },
                                      child: Text("스크랩하기", style: semibold_mpBL_16),
                                      style: TextButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: fFF,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(color: mpBL)
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                  width: Get.width * 0.4,
                                  height: 52,
                                  child: TextButton(
                                      onPressed: () {
                                        launch(_.contestDetailData['site_url']);
                                      },
                                      child: Text("지원하기", style: semibold_fFF_16),
                                      style: textButtonStyle)
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
            } else if (category=='대외활동'){
              return _.outdoorDetailData==null
                  ?Container()
                  :Stack(
                    children: [
                      SingleChildScrollView(
                child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: Get.width,
                          child: Image.network(
                            _.outdoorDetailData['image_url_introduction'].replaceAll('https', 'http'),
                            fit: BoxFit.fitHeight,
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
                          ),
                        ),
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_.outdoorDetailData['title'], style: normal_f33_20),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 2.0),
                                      child: Text(
                                          _.outdoorDetailData['founder'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: normal_f66_14
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 12.0),
                                      child: Text(
                                          "| "+_.outdoorDetailData['location'],
                                          style: normal_fBB_14
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 32,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        _.outdoorDetailData['relation_category'].length,
                                            (index) => Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Container(
                                            height: 32,
                                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: f245,
                                            ),
                                            child: Text(
                                                _.outdoorDetailData['relation_category'][index]['interest_name'],
                                                style: normal_f66_13
                                            ),
                                          ),
                                        )
                                    )
                                ),
                              ),
                              SizedBox(height: 11),
                              Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: f17F,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today_outlined, color: mpBL, size: 18),
                                        SizedBox(width: 5),
                                        Text("남은기한", style: normal_mpBL_16),
                                      ],
                                    ),
                                    Text(_.leftDate, style: semibold_mpBL_16),
                                    Text(_.outdoorDetailData["end_date"].toString().substring(5,7)+"월 "
                                        + _.outdoorDetailData["end_date"].toString().substring(8,10)+"일까지", style: normal_fBB_14),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("지원 자격", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.outdoorDetailData["eligibility"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("활동 내용", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.outdoorDetailData["activities"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("상세 정보", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.outdoorDetailData["detail_information"], style: normal_f33_16),
                              SizedBox(height: 32),
                              Text("활동 보상", style: semibold_f33_18),
                              SizedBox(height: 10),
                              Text(_.outdoorDetailData["benefits"], style: normal_f33_16),
                              SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
                      Positioned.fill(
                        bottom: 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: Get.width * 0.4,
                                  height: 52,
                                  child: TextButton(
                                      onPressed: () {
                                        _.postOutdoorBookmark(_.outdoorDetailData['id']);
                                      },
                                      child: Text("스크랩하기", style: semibold_mpBL_16),
                                      style: TextButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: fFF,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(color: mpBL)
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                  width: Get.width * 0.4,
                                  height: 52,
                                  child: TextButton(
                                      onPressed: () {
                                        launch(_.outdoorDetailData['site_url']);
                                      },
                                      child: Text("지원하기", style: semibold_fFF_16),
                                      style: textButtonStyle)
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
            }
            return Text(ID);
          }),
    );
  }
}
