import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class TeamController extends GetxController {
  final MyRepository repository;
  TeamController({required this.repository}) : assert(repository != null);

  GlobalKey<NavigatorState> teamMakingNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> teamDetailNavigatorKey = GlobalKey<NavigatorState>();

  List leader = [];
  List member = [];
  List waiting = [];
  List normal = [];
  getTeam() async {
    await repository.getTeam().then((data) {
      leader = data['team_leader'];
      member = data['team_members'];
      waiting = data['team_waiting'];
      normal = data['teams'];
    });
    update();
  }

  TextEditingController searchController = TextEditingController();

  List labels = [
    '공모전/해커톤',
    '스터디',
    '대외활동',
    '프로젝트',
    '기타'
  ];
  List selected = [
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void onInit() {
    getTeam();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
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