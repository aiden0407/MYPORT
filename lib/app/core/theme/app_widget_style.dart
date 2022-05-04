import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:folio/app/core/theme/app_colors.dart';

import 'app_text_theme.dart';

const PageDecoration pageDecoration1 = PageDecoration(
  contentMargin: EdgeInsets.only(top: 10),
  imagePadding: EdgeInsets.only(top: 80),
  imageFlex: 5,
  bodyFlex: 2,
  boxDecoration: BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.01,
      0.7,
    ],
    colors: [Color(0xffA9CBFF), Color(0xffFFFFFF)],
  )),
  titleTextStyle: bold_mpBL_21,
  bodyTextStyle: normal_f68_14,
);
const PageDecoration pageDecoration2 = PageDecoration(
  contentMargin: EdgeInsets.only(top: 10),
  imagePadding: EdgeInsets.only(top: 80),
  imageFlex: 5,
  bodyFlex: 2,
  boxDecoration: BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.01,
      0.7,
    ],
    colors: [Color(0xfff7c09e), Color(0xffFFFFFF)],
  )),
  titleTextStyle:
      TextStyle(fontWeight: FontWeight.w700, color: mpBL, fontSize: 21.0),
  bodyTextStyle: TextStyle(color: f68, fontSize: 14.0),
);
const PageDecoration pageDecoration3 = PageDecoration(
  contentMargin: EdgeInsets.only(top: 10),
  imagePadding: EdgeInsets.only(top: 80),
  imageFlex: 5,
  bodyFlex: 2,
  boxDecoration: BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.05,
      0.7,
    ],
    colors: [Color(0xffA9CBFF), Color(0xffFFFFFF)],
  )),
  titleTextStyle:
      TextStyle(fontWeight: FontWeight.w700, color: mpBL, fontSize: 21.0),
  bodyTextStyle: TextStyle(color: f68, fontSize: 14.0),
);

final ButtonStyle textButtonStyle = TextButton.styleFrom(
  padding: EdgeInsets.all(10),
  backgroundColor: mpBL,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
);
final ButtonStyle textButtonStyleDisabled = TextButton.styleFrom(
  padding: EdgeInsets.all(10),
  backgroundColor: f348,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
);
final ButtonStyle OutlinedButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(10),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  side: BorderSide(width: 0.75, color: mpBL),
);

GetDialog_GetOffAllNamed(String title, String text, String GetOffAllNamed) {
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
              SizedBox(height: 10),
              Text(text, style: TextStyle(fontSize: 14)),
              Expanded(child: Container()),
              Divider(),
              TextButton(
                onPressed: (){
                  Get.offAllNamed(GetOffAllNamed);
                  },
                child: Text("확인"),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

simpleDialog(double height, String text) {
  Get.dialog(
    Dialog(
      child: Container(
        height: height,
        child: Center(
            child: Text(text, textAlign: TextAlign.center)
        ),
      ),
    ),
  );
}

InputDecoration buildInputDecoration(String hintText) {
  return InputDecoration(
    focusedBorder:OutlineInputBorder(
      borderSide: BorderSide(color: f245, width: 0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintText: hintText,
    hintStyle: normal_fBB_16,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(8)),
      borderSide: BorderSide(
        color: f245,
      ),
    ),
    filled: true,
    fillColor: f245,
  );
}

InputDecoration buildSearchInputDecoration(String hintText) {
  return InputDecoration(
    prefixIcon: Icon(Icons.search, color: fAA),
    focusedBorder:OutlineInputBorder(
      borderSide: BorderSide(color: f245, width: 0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    hintText: hintText,
    hintStyle: normal_fBB_14,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(4)),
      borderSide: BorderSide(
        color: f245,
      ),
    ),
    filled: true,
    fillColor: f245,
  );
}