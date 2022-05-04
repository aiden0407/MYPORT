import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/modules/contest/contest_view.dart';
import 'package:folio/app/modules/home/home_view.dart';
import 'package:folio/app/modules/profile/profile_view.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_view.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Obx(
          () => Scaffold(
            //resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: controller.rootPageIndex.value,
              children: [
                Navigator(
                  key: controller.homeNavigatorKey,
                  onGenerateRoute: (routeSettings){
                    return MaterialPageRoute(builder: (context)=> HomeView());
                  },
                ),
                Navigator(
                  key: controller.teamNavigatorKey,
                  onGenerateRoute: (routeSettings){
                    return MaterialPageRoute(builder: (context)=> TeamView());
                  },
                ),
                Navigator(
                  key: controller.contestNavigatorKey,
                  onGenerateRoute: (routeSettings){
                    return MaterialPageRoute(builder: (context)=> ContestView());
                  },
                ),
                Navigator(
                  key: controller.profileNavigatorKey,
                  onGenerateRoute: (routeSettings){
                    return MaterialPageRoute(builder: (context)=> ProfileView());
                  },
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 1)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Obx(()=>BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: normal_f55_12,
                  selectedItemColor: f32,
                  unselectedLabelStyle: normal_f55_12,
                  unselectedItemColor: f32,
                  currentIndex: controller.rootPageIndex.value,
                  onTap: controller.changeRootPageIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: '홈',
                      activeIcon: Icon(Icons.home, color: mpBL),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_search_outlined),
                      label: '팀 만들기',
                      activeIcon: Icon(Icons.person_search_rounded, color: mpBL),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.flag_outlined),
                      label: '공모전',
                      activeIcon: Icon(Icons.flag_outlined, color: mpBL),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_rounded),
                      label: '내 정보',
                      activeIcon: Icon(Icons.person_rounded, color: mpBL),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
        onWillPop: controller.willPopAction);
  }
}
