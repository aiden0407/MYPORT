import 'package:flutter/material.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/modules/root/root_controller.dart';
import 'package:folio/app/modules/team/team_making/search_contest/search_contest_controller.dart';
import 'package:get/get.dart';

class SearchContestView extends GetView<SearchContestController> {
  final bool fromMaking;

  SearchContestView({
    required this.fromMaking
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("연관된 공모전 검색", style: semibold_f00_18),
        actions: [
          IconButton(
            icon: Icon(Icons.close_sharp, size: 24, color: Colors.black),
            onPressed: () {
              fromMaking
                  ?RootController.to.willPopAction()
                  :Get.back();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(controller.a),
      ),
    );
  }
}