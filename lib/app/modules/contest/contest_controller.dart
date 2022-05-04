import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

enum PageName {CONTEST, OUTDOOR, INTERN, HACKATHON, BOOKMARK}

class ContestController extends GetxController {
  final MyRepository repository;
  ContestController({required this.repository}) : assert(repository != null);

  GlobalKey<NavigatorState> contestDetailNavigatorKey = GlobalKey<NavigatorState>();
  RxInt contestPageIndex = 0.obs;
  RxBool isBookmarked = false.obs;
  RxInt lastPage = 0.obs;
  List<String> pages = ['공모전','대외활동','인턴','해커톤'];
  changeContestPageIndex(int value){
    var page = PageName.values[value];
    switch(page){
      case PageName.CONTEST:
      case PageName.OUTDOOR:
      case PageName.INTERN:
      case PageName.HACKATHON:
        if(isBookmarked.value){
          lastPage = value.obs;
          contestPageIndex(value);
          contestPageIndex(4);
        } else {
          lastPage = value.obs;
          contestPageIndex(value);
        }
        break;
      case PageName.BOOKMARK:
        if(isBookmarked.value){
          isBookmarked = false.obs;
          contestPageIndex(lastPage.value);
        } else {
          isBookmarked = true.obs;
          contestPageIndex(value);
        }
        break;
    }
    update();
  }
  RxDouble height = 50.0.obs;
  RxBool isExpanded = false.obs;


  List contestItemList = [];
  List contestBookmarkItemList = [];
  getContest() async {
    await repository.getContest().then((data) {
      contestBookmarkItemList = [];
      contestItemList = data;
      for(int i=0; i<contestItemList.length; i++){
        if(contestItemList[i]['interest']==true){
          contestBookmarkItemList.add(contestItemList[i]);
        }
      }
    });
    update();
  }
  postContestBookmark(ID, index) async {
    await repository.postContestBookmark(ID).then((data) {
      if(data) contestItemList[index]['interest'] = true;
      getContest();
    });
  }
  deleteContestBookmark(ID, index) async {
    await repository.deleteContestBookmark(ID).then((data) {
      if(data) contestItemList[index]['interest'] = false;
      getContest();
    });
  }
  TextEditingController contestSearchController = TextEditingController();
  List contestSearchFilterLabels = [
    '전체',
    '최신순',
    '인기순',
    '마감순',
  ];
  List contestSearchFilterSelected= [
    true,
    false,
    false,
    false,
  ];
  late List contestSearchFilterReturn = contestSearchFilterSelected;
  contestSearchFilterOnSelect(index) {
    contestSearchFilterSelected = [false, false, false, false];
    contestSearchFilterSelected[index] = true;
    update();
  }
  List contestSearchInterestLabels = [
    '기획/아이디어',
    '광고/마케팅',
    '디자인',
    '영상/콘텐츠',
    'IT/SW',
    '문학/시나리오',
    '스타트업/창업',
    '금융/경제',
    '봉사활동',
    '뷰티/패션',
    '스포츠/레저',
    '해외탐방',
    '기타'
  ];
  List contestSearchInterestSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List contestSearchInterestReturn = [false, false, false, false, false, false, false, false, false, false, false, false, false];
  contestSearchInterestOnSelect(index, value) {
    contestSearchInterestSelected[index] = value;
    update();
  }
  contestSearchSetting() {
    contestSearchFilterReturn = contestSearchFilterSelected;
    contestSearchInterestReturn = contestSearchInterestSelected;
    update();
  }
  contestSearchInitialize() {
    contestSearchFilterSelected = contestSearchFilterReturn;
    List saveContest = [];
    for (int i=0; i<contestSearchInterestReturn.length; i++){
      contestSearchInterestReturn[i]
          ?saveContest.add(true)
          :saveContest.add(false);
    }
    contestSearchInterestSelected = saveContest;
    update();
  }


  List outdoorItemList = [];
  List outdoorBookmarkItemList = [];
  getOutdoor() async {
    await repository.getOutdoor().then((data) {
      outdoorBookmarkItemList = [];
      outdoorItemList = data;
      for(int i=0; i<outdoorItemList.length; i++){
        if(outdoorItemList[i]['interest']==true){
          outdoorBookmarkItemList.add(outdoorItemList[i]);
        }
      }
    });
    update();
  }
  postOutdoorBookmark(ID, index) async {
    await repository.postOutdoorBookmark(ID).then((data) {
      if(data) outdoorItemList[index]['interest'] = true;
      getOutdoor();
    });
  }
  deleteOutdoorBookmark(ID, index) async {
    await repository.deleteOutdoorBookmark(ID).then((data) {
      if(data) outdoorItemList[index]['interest'] = false;
      getOutdoor();
    });
  }
  TextEditingController outdoorSearchController = TextEditingController();
  List outdoorSearchFilterLabels = [
    '전체',
    '최신순',
    '인기순',
    '마감순',
  ];
  List outdoorSearchFilterSelected= [
    true,
    false,
    false,
    false,
  ];
  late List outdoorSearchFilterReturn = outdoorSearchFilterSelected;
  outdoorSearchFilterOnSelect(index) {
    outdoorSearchFilterSelected = [false, false, false, false];
    outdoorSearchFilterSelected[index] = true;
    update();
  }
  List outdoorSearchInterestLabels = [
    '기획/아이디어',
    '광고/마케팅',
    '디자인',
    '영상/콘텐츠',
    'IT/SW',
    '문학/시나리오',
    '스타트업/창업',
    '금융/경제',
    '봉사활동',
    '뷰티/패션',
    '스포츠/레저',
    '해외탐방',
    '기타'
  ];
  List outdoorSearchInterestSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List outdoorSearchInterestReturn = [false, false, false, false, false, false, false, false, false, false, false, false, false];
  outdoorSearchInterestOnSelect(index, value) {
    outdoorSearchInterestSelected[index] = value;
    update();
  }
  outdoorSearchSetting() {
    outdoorSearchFilterReturn = outdoorSearchFilterSelected;
    outdoorSearchInterestReturn = outdoorSearchInterestSelected;
    update();
  }
  outdoorSearchInitialize() {
    outdoorSearchFilterSelected = outdoorSearchFilterReturn;
    List saveContest = [];
    for (int i=0; i<outdoorSearchInterestReturn.length; i++){
      outdoorSearchInterestReturn[i]
          ?saveContest.add(true)
          :saveContest.add(false);
    }
    outdoorSearchInterestSelected = saveContest;
    update();
  }



  @override
  void onInit() {
    getContest();
    getOutdoor();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class ContestListTile extends StatelessWidget {
  const ContestListTile({
    Key? key,
    required this.dday,
    required this.view,
    required this.like,
    required this.title,
    required this.founder,
    required this.thumbnail,
  }) : super(key: key);

  final int dday;
  final int view;
  final int like;
  final String title;
  final String founder;
  final Widget thumbnail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            //color: feff,
            height: 120,
            child: Row(
              children: [
                Expanded(
                  flex: 19,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //캘린더 아이콘 깨짐
                          //Image.asset('assets/icon/calendar_icon.png'),
                          Icon(Icons.event, color: mpBL, size: 18),
                          SizedBox(width: 5),
                          Text("D-"+dday.toString(), style: semibold_mpBL_14),
                          Expanded(child: Container()),
                          Icon(Icons.remove_red_eye, color: fDD, size: 18),
                          SizedBox(width: 5),
                          Text(view.toString(), style: normal_fBB_14),
                          SizedBox(width: 5),
                          Icon(Icons.bookmark, color: fDD, size: 18),
                          SizedBox(width: 5),
                          Text(like.toString(), style: normal_fBB_14),
                        ],
                      ),
                      SizedBox(height: 10),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                          text: title,
                          style: normal_f33_16
                        ),
                      ),
                      Expanded(child: Container(color: Colors.transparent)),
                      Row(
                        children: [
                          Text("주관", style: normal_fBB_14),
                          SizedBox(width: 5),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Text(founder,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: normal_f33_14),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(flex:1,child: Container()),
                thumbnail
              ],
            ),
          ),
        ),
        Divider(thickness: 1, color: feff)
      ],
    );
  }
}
class OutdoorListTile extends StatelessWidget {
  const OutdoorListTile({
    Key? key,
    required this.dday,
    required this.view,
    required this.like,
    required this.title,
    required this.founder,
    required this.thumbnail,
    required this.bookmark,
  }) : super(key: key);

  final int dday;
  final int view;
  final int like;
  final String title;
  final String founder;
  final Widget thumbnail;
  final bool bookmark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            //color: feff,
            height: 120,
            child: Row(
              children: [
                Expanded(
                  flex: 19,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //캘린더 아이콘 깨짐
                          //Image.asset('assets/icon/calendar_icon.png'),
                          Icon(Icons.event, color: mpBL, size: 18),
                          SizedBox(width: 5),
                          Text("D-"+dday.toString(), style: semibold_mpBL_14),
                          Expanded(child: Container()),
                          Icon(Icons.remove_red_eye, color: fDD, size: 18),
                          SizedBox(width: 5),
                          Text(view.toString(), style: normal_fBB_14),
                          SizedBox(width: 5),
                          Icon(Icons.bookmark, color: fDD, size: 18),
                          SizedBox(width: 5),
                          Text(like.toString(), style: normal_fBB_14),
                        ],
                      ),
                      SizedBox(height: 10),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                            text: title,
                            style: normal_f33_16
                        ),
                      ),
                      Expanded(child: Container(color: Colors.transparent)),
                      Row(
                        children: [
                          Text("주관", style: normal_fBB_14),
                          SizedBox(width: 5),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Text(founder,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: normal_f33_14),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(flex:1,child: Container()),
                thumbnail
              ],
            ),
          ),
        ),
        Divider(thickness: 1, color: feff)
      ],
    );
  }
}