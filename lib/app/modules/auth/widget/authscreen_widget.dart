import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';

class AuthScreenWidget extends StatelessWidget {
  final controller;
  AuthScreenWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(

      key: controller.keyIntroScreen,
      controlsMargin: EdgeInsets.only(bottom: 0),
      controlsPadding: EdgeInsets.only(bottom: 0),
      pages: [
        PageViewModel(
          useScrollView: false,
          decoration: pageDecoration1,
          image: Center( child: Image.asset('assets/images/auth_1.png',height: 220)),
          title: "대학생들을 위한\n맞춤형 네트워킹 플랫폼",
          body: "나와 비슷한 학생들은 지금\n어떤 활동을 하고 있는지 확인해 보세요",
        ),
        PageViewModel(
          useScrollView: false,
          decoration: pageDecoration2,
          image: Center( child: Image.asset('assets/images/auth_2.png',height: 300,)),
          title: "나만의 포트폴리오를 만들고\n멋진 팀에 합류해 봐요",
          body: "나만의 포트폴리오를 작성하고,\n함께 할 팀에 어필해 보세요",
        ),
        PageViewModel(
          useScrollView: false,
          decoration: pageDecoration3,
          image: Center( child: Image.asset('assets/images/auth_3.png',height: 300,)),
          title: "대학생들을 위한\n전문적인 네트워킹 플랫폼",
          body: "폴리오에서 나를 준비하고,\n더 넓은 세상으로 출발하세요",
        ),
      ],
      showNextButton: false,
      showDoneButton: false,
      showSkipButton: false,
      dotsFlex: 0,
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: mpBL,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
    );
  }
}
