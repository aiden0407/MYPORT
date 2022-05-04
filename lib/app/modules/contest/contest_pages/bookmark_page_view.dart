import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/modules/contest/contest_pages/bookmark_page_controller.dart';

class BookmarkPageView extends GetView<BookmarkPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.a),
      ),
    );
  }
}
