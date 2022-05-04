import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

enum PageName {HOME, TEAM, CONTEST, PROFILE}

class RootController extends GetxController {
  final MyRepository repository;
  RootController({required this.repository}) : assert(repository != null);

  static RootController get to => Get.find();

  GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> teamNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> contestNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();
  RxInt rootPageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeRootPageIndex(int value, {bool hasGesture = true}){
    var page = PageName.values[value];
    switch(page){
      case PageName.HOME:
      case PageName.TEAM:
      case PageName.CONTEST:
      case PageName.PROFILE:
        _changPage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changPage(int value, {bool hasGesture = true}) {
    rootPageIndex(value);
    if(!hasGesture) return;
    switch (value){
      case 0:
      case 1:
      case 2:
      case 3:
        if(bottomHistory.contains(value)){
          bottomHistory.remove(value);
        }
        bottomHistory.add(value);
        break;
    }
    if(bottomHistory.length==1 && bottomHistory[0]!=0)bottomHistory.insert(0,0);
  }

  Future<bool> willPopAction() async {
    var push = await homeNavigatorKey.currentState!.maybePop();
    if (push) return false;
    if(bottomHistory.length==1){
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
                  Text("시스템", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  SizedBox(height: 10),
                  Text("종료하시겠습니까?", style: TextStyle(fontSize: 14)),
                  Expanded(child: Container()),
                  Divider(),
                  TextButton(
                    onPressed: (){exit(0);},
                    child: Text("확인"),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      return true;
    } else {
      var page = PageName.values[bottomHistory.last];
      switch(page){
        case PageName.TEAM:
          var value = await teamNavigatorKey.currentState!.maybePop();
          if (value) return false;
          break;
        case PageName.CONTEST:
          var value = await contestNavigatorKey.currentState!.maybePop();
          if (value) return false;
          break;
        case PageName.PROFILE:
          var value = await profileNavigatorKey.currentState!.maybePop();
          if (value) return false;
          break;
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeRootPageIndex(index, hasGesture: false);
      if(bottomHistory.length==1 && bottomHistory[0]!=0)bottomHistory.insert(0,0);
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
