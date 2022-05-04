import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_controller.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_view.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/modules/contest/contest_controller.dart';

class ContestView extends GetView<ContestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GetBuilder<ContestController>(
            init: controller,
            builder: (_) => controller.isBookmarked.value
                ? IconButton(
                    icon: Icon(Icons.navigate_before,
                        size: 28, color: Colors.black),
                    onPressed: () {
                      controller.changeContestPageIndex(4);
                    },
                  )
                : Center()),
        actions: [
          GetBuilder<ContestController>(
              init: controller,
              builder: (_) => !controller.isBookmarked.value
                  ? IconButton(
                      icon: Icon(Icons.bookmark_outline,
                          size: 24, color: Colors.black),
                      onPressed: () {
                        controller.changeContestPageIndex(4);
                      },
                    )
                  : Center()),
          SizedBox(width: 2)
        ],
        title: GetBuilder<ContestController>(
            init: controller,
            builder: (_) => Text(
                controller.isBookmarked.value
                    ? '스크랩'
                    : controller.pages[controller.lastPage.value],
                style: semibold_f00_18)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Stack(
          children: [
            GetBuilder<ContestController>(
                init: controller,
                builder: (_) =>
                _.contestPageIndex.value == 0
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: Get.width,
                            height: 75,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: buildSearchInputDecoration(
                                        '공모전명, 분야를 검색해 보세요'),
                                    controller: controller.contestSearchController,
                                  ),
                                ),
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    _.contestSearchInitialize();
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0)
                                        ),
                                        useRootNavigator: true,
                                        context: context,
                                        builder: (BuildContext context){
                                      return Container(
                                        padding: EdgeInsets.only(top: Get.height*0.03,left: Get.width * 0.07, right: Get.width * 0.07),
                                        height: 515,
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
                                            Text("정렬기준", style: semibold_f33_18),
                                            SizedBox(height: 3),
                                            GetBuilder<ContestController>(
                                              init: controller,
                                              builder: (_) => Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  buildContestFilterChip(_, 0),
                                                  buildContestFilterChip(_, 1),
                                                  buildContestFilterChip(_, 2),
                                                  buildContestFilterChip(_, 3),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text("분야", style: semibold_f33_18),
                                            SizedBox(height: 3),
                                            GetBuilder<ContestController>(
                                              init: controller,
                                              builder: (_) => Wrap(
                                                spacing: 3,
                                                runSpacing: -5,
                                                children: [
                                                  buildContestInterestChip(_, 0),
                                                  buildContestInterestChip(_, 1),
                                                  buildContestInterestChip(_, 2),
                                                  buildContestInterestChip(_, 3),
                                                  buildContestInterestChip(_, 4),
                                                  buildContestInterestChip(_, 5),
                                                  buildContestInterestChip(_, 6),
                                                  buildContestInterestChip(_, 7),
                                                  buildContestInterestChip(_, 8),
                                                  buildContestInterestChip(_, 9),
                                                  buildContestInterestChip(_, 10),
                                                  buildContestInterestChip(_, 11),
                                                  buildContestInterestChip(_, 12),
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
                                                      controller.contestSearchSetting();
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
                                  child: Icon(Icons.tune_rounded,
                                      size: 30, color: fCC),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GetBuilder<ContestController>(
                                init: controller,
                                builder: (_) => ListView(
                                      children: List.generate(
                                        _.contestItemList.length,
                                        (index) => Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<ContestDetailController>().onInit();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                    ContestDetailView(
                                                      category: '공모전',
                                                      ID: _.contestItemList[index]['_id'],
                                                    ),
                                                ));
                                              },
                                              child: ContestListTile(
                                                  dday: _.contestItemList[index]['dday'],
                                                  view: _.contestItemList[index]['view'],
                                                  like: _.contestItemList[index]['like'],
                                                  title: _.contestItemList[index]['title'],
                                                  founder: _.contestItemList[index]['founder'],
                                                  thumbnail: Image.network(
                                                    _.contestItemList[index]['image_url_thumbnail'],
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
                                                  )),
                                            ),
                                            Positioned.fill(
                                              top: 20,
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: _.contestItemList[index]['interest']
                                                  ?GestureDetector(
                                                      onTap: (){
                                                        print("delete");
                                                        _.deleteContestBookmark(_.contestItemList[index]['_id'], index);
                                                      },
                                                      child: Icon(Icons.bookmark, color: mpBL)
                                                  )
                                                  :GestureDetector(
                                                    onTap: (){
                                                      print("post");
                                                      _.postContestBookmark(_.contestItemList[index]['_id'], index);
                                                    },
                                                      child: Icon(Icons.bookmark_outline, color: fFF)
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      )
                    : _.contestPageIndex.value == 1
                    ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: Get.width,
                      height: 75,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: buildSearchInputDecoration(
                                  '대외활동명, 분야를 검색해 보세요'),
                              controller: controller.outdoorSearchController,
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              _.outdoorSearchInitialize();
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  useRootNavigator: true,
                                  context: context,
                                  builder: (BuildContext context){
                                    return Container(
                                      padding: EdgeInsets.only(top: Get.height*0.03,left: Get.width * 0.07, right: Get.width * 0.07),
                                      height: 515,
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
                                          Text("정렬기준", style: semibold_f33_18),
                                          SizedBox(height: 3),
                                          GetBuilder<ContestController>(
                                            init: controller,
                                            builder: (_) => Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                buildOutdoorFilterChip(_, 0),
                                                buildOutdoorFilterChip(_, 1),
                                                buildOutdoorFilterChip(_, 2),
                                                buildOutdoorFilterChip(_, 3),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Text("분야", style: semibold_f33_18),
                                          SizedBox(height: 3),
                                          GetBuilder<ContestController>(
                                            init: controller,
                                            builder: (_) => Wrap(
                                              spacing: 3,
                                              runSpacing: -5,
                                              children: [
                                                buildOutdoorInterestChip(_, 0),
                                                buildOutdoorInterestChip(_, 1),
                                                buildOutdoorInterestChip(_, 2),
                                                buildOutdoorInterestChip(_, 3),
                                                buildOutdoorInterestChip(_, 4),
                                                buildOutdoorInterestChip(_, 5),
                                                buildOutdoorInterestChip(_, 6),
                                                buildOutdoorInterestChip(_, 7),
                                                buildOutdoorInterestChip(_, 8),
                                                buildOutdoorInterestChip(_, 9),
                                                buildOutdoorInterestChip(_, 10),
                                                buildOutdoorInterestChip(_, 11),
                                                buildOutdoorInterestChip(_, 12),
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
                                                    controller.outdoorSearchSetting();
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
                            child: Icon(Icons.tune_rounded,
                                size: 30, color: fCC),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GetBuilder<ContestController>(
                          init: controller,
                          builder: (_) => ListView(
                            children: List.generate(
                              _.outdoorItemList.length,
                                  (index) => Stack(
                                    children: [
                                      GestureDetector(
                                onTap: () {
                                      Get.find<ContestDetailController>().onInit();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContestDetailView(category: '대외활동',ID: _.outdoorItemList[index]['_id'],)));
                                },
                                child: OutdoorListTile(
                                        dday: _.outdoorItemList[index]['dday'],
                                        view: _.outdoorItemList[index]['view'],
                                        like: _.outdoorItemList[index]['like'],
                                        title: _.outdoorItemList[index]['title'],
                                        founder: _.outdoorItemList[index]['founder'],
                                        thumbnail: Image.network(
                                          _.outdoorItemList[index]['image_url_thumbnail'],
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
                                        ),
                                        bookmark: _.outdoorItemList[index]['interest']),
                              ),
                                      Positioned.fill(
                                        top: 20,
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: _.outdoorItemList[index]['interest']
                                                ?GestureDetector(
                                                onTap: (){
                                                  print("delete");
                                                  _.deleteOutdoorBookmark(_.outdoorItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark, color: mpBL)
                                            )
                                                :GestureDetector(
                                                onTap: (){
                                                  print("post");
                                                  _.postOutdoorBookmark(_.outdoorItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark_outline, color: fFF)
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                            ),
                          )),
                    ),
                  ],
                )
                    : _.contestPageIndex.value == 4 && _.lastPage.value==0
                    ? Expanded(
                      child: GetBuilder<ContestController>(
                          init: controller,
                          builder: (_) => ListView(
                            children: List.generate(
                              _.contestBookmarkItemList.length,
                                  (index) => Stack(
                                    children: [
                                      GestureDetector(
                                onTap: () {
                                      Get.find<ContestDetailController>().onInit();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContestDetailView(category: '공모전',ID: _.contestItemList[index]['_id'],)));
                                },
                                child: ContestListTile(
                                        dday: _.contestBookmarkItemList[index]['dday'],
                                        view: _.contestBookmarkItemList[index]['view'],
                                        like: _.contestBookmarkItemList[index]['like'],
                                        title: _.contestBookmarkItemList[index]['title'],
                                        founder: "founder API not exist",
                                        thumbnail: Image.network(
                                          _.contestBookmarkItemList[index]['image_url_thumbnail'],
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
                                        )),
                              ),
                                      Positioned.fill(
                                        top: 20,
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: _.contestBookmarkItemList[index]['interest']
                                                ?GestureDetector(
                                                onTap: (){
                                                  print("delete");
                                                  _.deleteContestBookmark(_.contestBookmarkItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark, color: mpBL)
                                            )
                                                :GestureDetector(
                                                onTap: (){
                                                  print("post");
                                                  _.postContestBookmark(_.contestBookmarkItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark_outline, color: fFF)
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                            ),
                          )),
                    )
                    : _.contestPageIndex.value == 4 && _.lastPage.value==1
                    ? Expanded(
                      child: GetBuilder<ContestController>(
                          init: controller,
                          builder: (_) => ListView(
                            children: List.generate(
                              _.outdoorBookmarkItemList.length,
                                  (index) => Stack(
                                    children: [
                                      GestureDetector(
                                onTap: () {
                                      Get.find<ContestDetailController>().onInit();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContestDetailView(category: '대외활동',ID: _.outdoorItemList[index]['_id'],)));
                                },
                                child: OutdoorListTile(
                                        dday: _.outdoorBookmarkItemList[index]['dday'],
                                        view: _.outdoorBookmarkItemList[index]['view'],
                                        like: _.outdoorBookmarkItemList[index]['like'],
                                        title: _.outdoorBookmarkItemList[index]['title'],
                                        founder: "founder API not exist",
                                        thumbnail: Image.network(
                                          _.outdoorBookmarkItemList[index]['image_url_thumbnail'],
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
                                        ),
                                        bookmark: _.outdoorBookmarkItemList[index]['interest']),
                              ),
                                      Positioned.fill(
                                        top: 20,
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: _.outdoorBookmarkItemList[index]['interest']
                                                ?GestureDetector(
                                                onTap: (){
                                                  print("delete");
                                                  _.deleteOutdoorBookmark(_.outdoorBookmarkItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark, color: mpBL)
                                            )
                                                :GestureDetector(
                                                onTap: (){
                                                  print("post");
                                                  _.postOutdoorBookmark(_.outdoorBookmarkItemList[index]['_id'], index);
                                                },
                                                child: Icon(Icons.bookmark_outline, color: fFF)
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                            ),
                          )),
                    )
                    : Container()
            ),
            Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => AnimatedContainer(
                    height: controller.height.value,
                    width: 120,
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: mpBL,
                        borderRadius: !controller.isExpanded.value
                            ? BorderRadius.circular(30)
                            : BorderRadius.circular(25)),
                    child: !controller.isExpanded.value
                        ? GestureDetector(
                            onTap: () {
                              controller.isExpanded = true.obs;
                              controller.height.value += 30;
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    controller.pages[controller.lastPage.value],
                                    style: semibold_fFF_16,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.isExpanded = false.obs;
                                          controller.height.value -= 30;
                                          controller.changeContestPageIndex(0);
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '공모전',
                                                style: semibold_fFF_16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      GestureDetector(
                                        onTap: () {
                                          controller.isExpanded = false.obs;
                                          controller.height.value -= 30;
                                          controller.changeContestPageIndex(1);
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '대외활동',
                                                style: semibold_fFF_16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 13),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     controller.isExpanded = false.obs;
                                      //     controller.height.value -= 100;
                                      //     controller.changeContestPageIndex(2);
                                      //   },
                                      //   child: Center(
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //         Text('인턴',
                                      //           style: semibold_FF_16,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(height: 13),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     controller.isExpanded = false.obs;
                                      //     controller.height.value -= 100;
                                      //     controller.changeContestPageIndex(3);
                                      //   },
                                      //   child: Center(
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //         Text('해커톤',
                                      //           style: semibold_FF_16,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down,
                                          color: controller.lastPage.value == 0
                                              ? Colors.white
                                              : mpBL),
                                      SizedBox(height: 8),
                                      Icon(Icons.keyboard_arrow_down,
                                          color: controller.lastPage.value == 1
                                              ? Colors.white
                                              : mpBL),
                                      // SizedBox(height: 8),
                                      // Icon(
                                      //     Icons.keyboard_arrow_down,
                                      //     color: controller.lastPage.value==2
                                      //         ? Colors.white : mpBL
                                      // ),
                                      // SizedBox(height: 8),
                                      // Icon(
                                      //     Icons.keyboard_arrow_down,
                                      //     color: controller.lastPage.value==3
                                      //         ? Colors.white : mpBL
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FilterChip buildContestFilterChip(ContestController _, int index) {
    return FilterChip(
      label: Text(_.contestSearchFilterLabels[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
              _.contestSearchFilterSelected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.contestSearchFilterSelected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.contestSearchFilterSelected[index],
      onSelected: (bool value) {
        _.contestSearchFilterOnSelect(index);
      },
    );
  }
  FilterChip buildContestInterestChip(ContestController _, int index) {
    return FilterChip(
      label: Text(_.contestSearchInterestLabels[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
              _.contestSearchInterestSelected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.contestSearchInterestSelected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.contestSearchInterestSelected[index],
      onSelected: (bool value) {
        _.contestSearchInterestOnSelect(index,value);
      },
    );
  }
  FilterChip buildOutdoorFilterChip(ContestController _, int index) {
    return FilterChip(
      label: Text(_.outdoorSearchFilterLabels[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
              _.outdoorSearchFilterSelected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.outdoorSearchFilterSelected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.outdoorSearchFilterSelected[index],
      onSelected: (bool value) {
        _.outdoorSearchFilterOnSelect(index);
      },
    );
  }
  FilterChip buildOutdoorInterestChip(ContestController _, int index) {
    return FilterChip(
      label: Text(_.outdoorSearchInterestLabels[index],
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
              _.outdoorSearchInterestSelected[index] ? Color(0xff428EFF) : Color(0xff9B9B9B))),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      shape: BeveledRectangleBorder(
        side: BorderSide(
            color: _.outdoorSearchInterestSelected[index] ? Color(0xff428EFF) : Color(0xffEFF2FB),
            width: 1),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xffF1F7FF),
      showCheckmark: false,
      selected: _.outdoorSearchInterestSelected[index],
      onSelected: (bool value) {
        _.outdoorSearchInterestOnSelect(index,value);
      },
    );
  }
}
