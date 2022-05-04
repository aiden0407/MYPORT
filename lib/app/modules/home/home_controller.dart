import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class HomeController extends GetxController {
  final MyRepository repository;
  HomeController({required this.repository}) : assert(repository != null);

  GlobalKey<NavigatorState> contestReadyNavigatorKey = GlobalKey<NavigatorState>();

  int refreshPage = 0;

  List user=[];
  List contest=[];
  List team=[];
  int portfolioPercentage = 0;

  getHome() async {
    await repository.getHome().then((data) {
      user = data['users'];
      contest = data['contests'];
      team = data['teams'];
      portfolioPercentage = data['completion_rate'];
    });
    update();
  }

  @override
  void onInit() {
    getHome();
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
    required this.title,
    required this.founder,
    required this.thumbnail,
    required this.relation_category,
  }) : super(key: key);

  final int dday;
  final String title;
  final String founder;
  final Widget thumbnail;
  final List<dynamic> relation_category;

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
                          Icon(Icons.event, color: mpBL, size: 18),
                          SizedBox(width: 5),
                          Text("D-"+dday.toString(), style: semibold_mpBL_14),
                          Expanded(child: Container()),
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
                      Container(
                        height: 30,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                relation_category.length,
                                    (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: f17F,
                                    ),
                                    child: Text(
                                        relation_category[index]['interest_name'],
                                        style: normal_mpBL_12
                                    ),
                                  ),
                                )
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex:1,child: Container()),
                thumbnail
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class TeamListTile extends StatelessWidget {
  const TeamListTile({
    Key? key,
    required this.iconColor,
    required this.memberInfo,
    required this.textStyle,
    required this.last,
    required this.count,
    required this.title,
    required this.thumbnail,
    required this.relation_category,
  }) : super(key: key);

  final Color iconColor;
  final String memberInfo;
  final TextStyle textStyle;
  final bool last;
  final int count;
  final String title;
  final Widget thumbnail;
  final String relation_category;

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
                          Icon(Icons.group, color: iconColor, size: 18),
                          SizedBox(width: 9),
                          Text(count.toString()+"명 | "+memberInfo, style: textStyle),
                          Expanded(child: Container()),
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
                      Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: f17F,
                        ),
                        child: Text(
                            relation_category,
                            style: normal_mpBL_12
                        ),
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
        last?Container():Divider(thickness: 1, color: feff)
      ],
    );
  }
}