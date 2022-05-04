import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:folio/app/core/theme/app_colors.dart';
import 'package:folio/app/core/theme/app_text_theme.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/modules/signup/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  final PageController pageController = PageController();
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.image = File(pickedFile.path);
      controller.imagePath = pickedFile.path;
      controller.imageNull = false.obs;
      controller.update();
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: Get.height,
          child: WillPopScope(
            onWillPop: () async {
              if (pageController.page == pageController.initialPage) {
                return Future(() => true);
              } else {
                pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                return Future(() => false);
              }
            },
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                Column(
                  children: [
                    buildTop(
                      "1/4",
                      "이름을\n입력해 주세요",
                      TextField(
                        onChanged: (value) {
                          controller.name = value;
                          controller.nameButtonValidator();
                        },
                        controller: controller.nameController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            hintText: "이름 입력",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                            ),
                        ),
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) =>
                          buildNextButton(_.isNameButtonValid == true),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "2/4",
                      "전화번호를\n입력해 주세요",
                      Column(
                        children: [
                          Stack(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  controller.certifyButtonValidator();
                                },
                                controller: controller.phoneController,
                                style: TextStyle(fontSize: 20),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                  LengthLimitingTextInputFormatter(11)
                                ],
                                decoration: InputDecoration(
                                    hintText: "전화번호 입력",
                                    hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 20,
                                    )),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: Get.width * 0.58),
                                  GetBuilder<SignUpController>(
                                    init: controller,
                                    builder: (_) => OutlinedButton(
                                        onPressed: () {
                                          if (_.isCertifyButtonValid == true) {
                                            _.getPhone(_.phoneController.text);
                                          }
                                        },
                                        child: Text("인증번호",
                                          style: _.isCertifyButtonValid == true?
                                          TextStyle(color: mpBL) : TextStyle(color: fBF)
                                        ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) => TextField(
                              enabled: _.isInputCertificationValid == true,
                              onChanged: (value) {
                                controller.phoneButtonValidator();
                              },
                              controller: controller.certificationController,
                              style: TextStyle(fontSize: 20),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(5)
                              ],
                              decoration: InputDecoration(
                                  hintText: "인증번호 입력",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) => Container(
                        height: Get.height * 0.15,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.8,
                              height: Get.height * 0.065,
                              child: TextButton(
                                onPressed: _.isPhoneButtonValid.value? () {
                                      if (_.certificationCode == controller.certificationController.text) {
                                        pageController.nextPage(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      } else {
                                        simpleDialog(100, '인증번호를 다시 확인해주세요');
                                      }
                                }:null,
                                child: Text("다음으로",
                                    style: _.isPhoneButtonValid == true
                                        ? inTextButton
                                        : inTextButtonDisabled),
                                style: _.isPhoneButtonValid == true
                                    ? textButtonStyle
                                    : textButtonStyleDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "3/4",
                      "생년월일을\n입력해 주세요",
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                controller.birth = value;
                                controller.birthButtonValidator();
                              },
                              controller: controller.birthController,
                              style: TextStyle(fontSize: 20),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(6)
                              ],
                              decoration: InputDecoration(
                                  hintText: "생년월일",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 20,
                                  ),
                              ),
                            ),
                          ),
                          Text("    -    ", style:bold_f00_21),
                          Container(
                            width: Get.width*0.05,
                            child: TextField(
                              onChanged: (value) {
                                controller.gender = value;
                                controller.birthButtonValidator();
                              },
                              controller: controller.genderController,
                              style: TextStyle(fontSize: 20),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[1-4]')),
                                LengthLimitingTextInputFormatter(1)
                              ],
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Text(" ●●●●●●", style:bold_f00_21)
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) =>
                          buildNextButton(_.isBirthButtonValid == true),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "4/4",
                      "이메일과 비밀번호를\n입력해 주세요",
                      Column(
                        children: [
                          Stack(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  controller.emailCertifyButtonValidator();
                                },
                                controller: controller.emailController,
                                style: TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                    hintText: "이메일",
                                    hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 20,
                                    )),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: Get.width * 0.58),
                                  GetBuilder<SignUpController>(
                                    init: controller,
                                    builder: (_) => OutlinedButton(
                                        onPressed: () {
                                          if (_.isEmailCertifyButtonValid == true) {
                                            _.getEmail(_.emailController.text);
                                          }
                                        },
                                        child: Text("중복확인",
                                            style: _.isEmailCertifyButtonValid == true?
                                            TextStyle(color: mpBL) : TextStyle(color: fBF)
                                        ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          TextField(
                            obscureText: true,
                            onChanged: (value) {
                              controller.emailButtonValidator();
                              },
                              controller: controller.passwordController,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  hintText: "비밀번호",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 20,
                                  ),
                              ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            obscureText: true,
                            onChanged: (value) {
                              controller.emailButtonValidator();
                            },
                            controller: controller.passwordCheckController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "비밀번호 확인",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) => Container(
                        height: Get.height * 0.15,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.8,
                              height: Get.height * 0.065,
                              child: TextButton(
                                onPressed:_.isEmailButtonValid.value? () {
                                    if(_.passwordController.text == _.passwordCheckController.text){
                                      if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$").hasMatch(_.passwordController.text)) {
                                        _.password = _.passwordController.text;
                                        pageController.nextPage(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      } else {
                                        simpleDialog(100, '비밀번호는 특수문자, 대소문자, 숫자 포함\n8자 이상 16자 이내로 입력하세요.');
                                      }
                                    } else {
                                      simpleDialog(100, '비밀번호가 일치하지 않습니다.');
                                    }
                                }:null,
                                child: Text("다음으로",
                                    style: _.isEmailButtonValid == true
                                        ? inTextButton
                                        : inTextButtonDisabled),
                                style: _.isEmailButtonValid == true
                                    ? textButtonStyle
                                    : textButtonStyleDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.85,
                      width: Get.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.13),
                          buildTitleText("아래 정보들을\n확인해 주세요"),
                          SizedBox(height: Get.height * 0.03),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              GestureDetector(
                                onTap: getImage,
                                child: Container(
                                  height: 104,
                                  width: 104,
                                  decoration: BoxDecoration(
                                      color: fDD, shape: BoxShape.circle),
                                  child: GetBuilder<SignUpController>(
                                    init: controller,
                                    builder: (_) => controller.imageNull == true
                                        ? Icon(Icons.person_rounded, size: 50, color: fF9)
                                        : Container(height: 104, width: 104,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: FileImage(_.image),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Container(height: 32, width: 32,
                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                                  border: Border.all(
                                  width: 1,
                                  color: fF1,
                                ),
                              ),
                                child: Icon(Icons.create_outlined, size: 20, color: fAA),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.05),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) => controller.phone.length == 11 && controller.birth.length == 6 ?
                                buildTitleText2(_.name,
                                _.phone.substring(0,3)+"-"+_.phone.substring(3,7)+"-"+_.phone.substring(7),
                                _.birth.substring(0,2)+"년 "+_.birth.substring(2,4)+"월 "+_.birth.substring(4)+"일"): Center()
                          ),
                        ],
                      ),
                    ),
                    buildNextButton(true)
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.85,
                      width: Get.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.13),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) => controller.imageNull == true
                                ? Container( height: 48, width: 48,
                                    decoration: BoxDecoration(color: fDD, shape: BoxShape.circle),
                                    child: Icon(Icons.person_rounded, size: 34, color: fF9),
                                ) : Container(height: 48, width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(_.image),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) => buildTitleText("반가워요! "+_.name+"님\n몇 가지 정보를 물어볼요")
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Text("폴리오를 더 알차게 사용하기 위해\n몇 가지 정보를 더 물어볼게요",style: normal_f63_16),
                          Flexible(child: Container()),
                          Center(
                              child: Image.asset(
                                'assets/images/sign_up_1.png',
                              ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.15,
                      child: Column(
                        children: [
                          SizedBox(
                            width: Get.width * 0.8,
                            height: Get.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                                if(controller.allUniv.length==0){
                                  controller.getRegion();
                                  controller.getRegionDetail('11');
                                  controller.getUniv();
                                }
                                pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                              },
                              child: Text("다음으로", style: inTextButton),
                              style: textButtonStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "1/4",
                      "어느 대학교를 나오셨나요?\n동문을 찾아드려요",
                      Container(
                        height: Get.height*0.5,
                        child: Column(
                          children: [
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  controller.univFocusOnValidator();
                                  controller.runFilter(controller.univController.text);
                                  if(controller.allUniv.contains(controller.university)){
                                    controller.allMajor = controller.univList[controller.allUniv.indexOf(controller.university)].major_name;
                                  }
                                } else {
                                  controller.univFocusOutValidator();
                                  controller.runFilter(controller.univController.text);
                                  controller.univButtonValidator();
                                  if(controller.allUniv.contains(controller.university)){
                                    controller.allMajor = controller.univList[controller.allUniv.indexOf(controller.university)].major_name;
                                  }
                                }
                              },
                              child: TextField(
                                onChanged: (value) {
                                  controller.university = value;
                                  controller.univButtonValidator();
                                  controller.runFilter(value);
                                  if(controller.allUniv.contains(controller.university)){
                                    controller.allMajor = controller.univList[controller.allUniv.indexOf(controller.university)].major_name;
                                  }
                                },
                                controller: controller.univController,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    hintText: "대학교 검색",
                                    hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 20,
                                    ),
                                ),
                              ),
                            ),
                            Flexible(child: GetBuilder<SignUpController>(
                              init: controller,
                              builder: (_) =>
                              _.isUnivFocused == true ?ListView.builder(
                                padding: EdgeInsets.only(top: 0),
                                itemCount: _.resultsUniv.length,
                                itemBuilder: (context, index) =>
                                    ListTile(
                                      title: Text(_.resultsUniv[index]),
                                      onTap: () {
                                        _.univController.text = _.resultsUniv[index];
                                        _.university = _.resultsUniv[index];
                                        if(controller.allUniv.contains(_.university)){
                                          _.allMajor = _.univList[_.allUniv.indexOf(_.university)].major_name;
                                        }
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        currentFocus.unfocus();
                                      },
                                    ),
                              ) : SizedBox(height: 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) => buildNextButton(_.isUnivButtonValid == true),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "2/4",
                      "전공과 학번을 알려주시면\n맞춤 정보를 제공해요",
                      Container(
                        height: Get.height*0.5,
                        child: Column(
                          children: [
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  controller.majorFocusOnValidator();
                                  controller.runFilterMajor(controller.majorController.text);
                                } else {
                                  controller.majorFocusOutValidator();
                                  controller.majorButtonValidator();
                                }
                              },
                              child: TextField(
                                onChanged: (value) {
                                  controller.major = value;
                                  controller.majorButtonValidator();
                                  controller.runFilterMajor(value);
                                },
                                controller: controller.majorController,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  hintText: "전공 검색",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                child: GetBuilder<SignUpController>(
                              init: controller,
                              builder: (_) => _.isMajorFocused == true
                                  ? ListView.builder(
                                      padding: EdgeInsets.only(top: 0),
                                      itemCount: _.resultsMajor.length,
                                      itemBuilder: (context, index) => ListTile(
                                        title: Text(_.resultsMajor[index]),
                                        onTap: () {
                                          _.majorController.text =
                                              _.resultsMajor[index];
                                          _.major = _.resultsMajor[index];
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          currentFocus.unfocus();
                                        },
                                      ),
                                    )
                                      : DropdownButton2(
                                          value: _.selectedDropdownGrade,
                                          items: [
                                            for (var data in _.grades)
                                              DropdownMenuItem(
                                                child: new Text(data, style: TextStyle(fontSize: 18)),
                                                value: data,
                                              ),
                                          ],
                                          onChanged: (newValue) {
                                            _.selectedDropdownGrade =
                                                newValue.toString();
                                            _.update();
                                          },
                                          underline: Container(
                                            height: 1,
                                            color: fBF,
                                          ),
                                          isExpanded: true,
                                          dropdownElevation: 1,
                                          buttonPadding: EdgeInsets.only(top:18),
                                          dropdownMaxHeight: 200,
                                          scrollbarRadius: const Radius.circular(40),
                                          scrollbarAlwaysShow: true,
                                        )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) => buildNextButton(_.isMajorButtonValid == true),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildTop(
                      "3/4",
                      "내 동네를 알려주시면\n더 정확한 맞춤 정보를 제공해요",
                      Column(
                        children: [
                          GetBuilder<SignUpController>(
                              init: controller,
                              builder: (_) => DropdownButton2(
                                value: _.selectedDropdownRegion,
                                items: [
                                  for (var data in _.allRegion)
                                    DropdownMenuItem(
                                      child: new Text(data, style: TextStyle(fontSize: 18)),
                                      value: data,
                                    ),
                                ],
                                onChanged: (newValue) {
                                  _.selectedDropdownRegion = newValue.toString();
                                  print(_.regionList[_.allRegion.indexOf(_.selectedDropdownRegion)].code.substring(0,2));
                                  _.getRegionDetail(_.regionList[_.allRegion.indexOf(_.selectedDropdownRegion)].code.substring(0,2));
                                  _.update();
                                },
                                underline: Container(
                                  height: 1,
                                  color: fBF,
                                ),
                                isExpanded: true,
                                dropdownElevation: 1,
                                buttonPadding: EdgeInsets.only(top:10),
                                dropdownMaxHeight: 200,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarAlwaysShow: true,
                              )
                          ),
                          GetBuilder<SignUpController>(
                              init: controller,
                              builder: (_) => DropdownButton2(
                                value: _.selectedDropdownRegionDetail,
                                items: [
                                  for (var data in _.allRegionDetail)
                                    DropdownMenuItem(
                                      child: new Text(data, style: TextStyle(fontSize: 18)),
                                      value: data,
                                    ),
                                ],
                                onChanged: (newValue) {
                                  _.selectedDropdownRegionDetail = newValue.toString();
                                  _.update();
                                },
                                underline: Container(
                                  height: 1,
                                  color: fBF,
                                ),
                                isExpanded: true,
                                dropdownElevation: 1,
                                buttonPadding: EdgeInsets.only(top:10),
                                dropdownMaxHeight: 200,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarAlwaysShow: true,
                              )
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) => buildNextButton(true),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.85,
                      width: Get.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.15),
                          buildNumberContainer("4/4"),
                          SizedBox(height: 16),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) =>
                                buildTitleText(_.name+"님이 관심있는 분야를\n3가지만 알려주세요"),
                          ),
                          SizedBox(height: 40),
                          GetBuilder<SignUpController>(
                            init: controller,
                            builder: (_) => Wrap(
                              spacing: 5,
                              runSpacing: 1,
                              children: [
                                FilterChip(
                                  label: Text(_.labels[0],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[0]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[0]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[0],
                                  onSelected: (bool value) {
                                    _.selected[0] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[1],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[1]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[1]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[1],
                                  onSelected: (bool value) {
                                    _.selected[1] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[2],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[2]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[2]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[2],
                                  onSelected: (bool value) {
                                    _.selected[2] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[3],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[3]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[3]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[3],
                                  onSelected: (bool value) {
                                    _.selected[3] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[4],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[4]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[4]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[4],
                                  onSelected: (bool value) {
                                    _.selected[4] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[5],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[5]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[5]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[5],
                                  onSelected: (bool value) {
                                    _.selected[5] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[6],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[6]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[6]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[6],
                                  onSelected: (bool value) {
                                    _.selected[6] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[7],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[7]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[7]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[7],
                                  onSelected: (bool value) {
                                    _.selected[7] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[8],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[8]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[8]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[8],
                                  onSelected: (bool value) {
                                    _.selected[8] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[9],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[9]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[9]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[9],
                                  onSelected: (bool value) {
                                    _.selected[9] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[10],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[10]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[10]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[10],
                                  onSelected: (bool value) {
                                    _.selected[10] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[11],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[11]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[11]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[11],
                                  onSelected: (bool value) {
                                    _.selected[11] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                                FilterChip(
                                  label: Text(_.labels[12],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: _.selected[12]
                                              ? Color(0xff428EFF)
                                              : Color(0xff9B9B9B))),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
                                  shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: _.selected[12]
                                            ? Color(0xff428EFF)
                                            : Color(0xffEFF2FB),
                                        width: 1),
                                  ),
                                  backgroundColor: Colors.white,
                                  selectedColor: Color(0xffF1F7FF),
                                  showCheckmark: false,
                                  selected: _.selected[12],
                                  onSelected: (bool value) {
                                    _.selected[12] = value;
                                    _.interestButtonValidator();
                                    _.update();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      init: controller,
                      builder: (_) =>
                          buildNextButton(_.isInterestButtonValid == true),
                    ),
                  ],
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height:Get.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.8,
                            ],
                            colors: [Color(0xffE8f2ff), Color(0xffFFFFFF)],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * 0.85,
                              width: Get.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: Get.height * 0.16),
                                  Text("Welcome", style: bold_mpBL_24),
                                  SizedBox(height: Get.height * 0.03),
                                  Text("반가워요!\n앞으로 잘 부탁해요", style: bold_f00_24, textAlign: TextAlign.center),
                                  SizedBox(height: Get.height * 0.02),
                                  Text("대학생들의 컨설턴트\n폴리오와 함께 성장해 봐요!", style: normal_f63_16, textAlign: TextAlign.center),
                                  Flexible(child: Center(child: Image.asset('assets/images/sign_up_2.png'))),
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height * 0.15,
                              width: Get.width * 0.8,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.8,
                                    height: Get.height * 0.065,
                                    child: TextButton(
                                      child: Text("다음으로", style: inTextButton),
                                      style: textButtonStyle,
                                      onPressed: () {
                                        Get.bottomSheet(
                                          Container(
                                            padding: EdgeInsets.only(top: Get.height*0.05,left: Get.width * 0.1, right: Get.width * 0.1),
                                            height: Get.height*0.45,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: const Radius.circular(40.0),
                                                  topRight: const Radius.circular(40.0),
                                                ),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('폴리오 이용약관 동의', style: semibold_f33_16),
                                                        SizedBox(height: 2),
                                                        GestureDetector(
                                                            child: Text('자세히 보기', style: normal_fBB_12),
                                                            onTap: (){},
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(child: Container()),
                                                    Transform.scale(
                                                      scale: 1.5,
                                                      child: GetBuilder<SignUpController>(
                                                          init: controller,
                                                          builder: (_) => Checkbox(
                                                            activeColor: Colors.white,
                                                            checkColor: mpBL,
                                                            value: _.isChecked1,
                                                            shape: CircleBorder(),
                                                            side: BorderSide(color: mpBL,width: 1),
                                                            onChanged: (bool? value) {
                                                              _.isChecked1 = value!;
                                                              _.agreeButtonValidator();
                                                              _.update();
                                                            },
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('개인정보 수집 및 이용 동의', style: semibold_f33_16),
                                                        SizedBox(height: 2),
                                                        GestureDetector(
                                                          child: Text('자세히 보기', style: normal_fBB_12),
                                                          onTap: (){},
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(child: Container()),
                                                    Transform.scale(
                                                      scale: 1.5,
                                                      child: GetBuilder<SignUpController>(
                                                          init: controller,
                                                          builder: (_) => Checkbox(
                                                            activeColor: Colors.white,
                                                            checkColor: mpBL,
                                                            value: _.isChecked2,
                                                            shape: CircleBorder(),
                                                            side: BorderSide(color: mpBL,width: 1),
                                                            onChanged: (bool? value) {
                                                              _.isChecked2 = value!;
                                                              _.agreeButtonValidator();
                                                              _.update();
                                                            },
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('위치정보 이용약관(선택)', style: semibold_f33_16),
                                                        SizedBox(height: 2),
                                                        GestureDetector(
                                                          child: Text('자세히 보기', style: normal_fBB_12),
                                                          onTap: (){},
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(child: Container()),
                                                    Transform.scale(
                                                      scale: 1.5,
                                                      child: GetBuilder<SignUpController>(
                                                          init: controller,
                                                          builder: (_) => Checkbox(
                                                            activeColor: Colors.white,
                                                            checkColor: mpBL,
                                                            value: _.isChecked3,
                                                            shape: CircleBorder(),
                                                            side: BorderSide(color: mpBL,width: 1),
                                                            onChanged: (bool? value) {
                                                              _.isChecked3 = value!;
                                                              _.update();
                                                            },
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                Container(
                                                  height: Get.height * 0.15,
                                                  width: Get.width * 0.8,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * 0.8,
                                                        height: Get.height * 0.065,
                                                        child: GetBuilder<SignUpController>(
                                                            init: controller,
                                                            builder: (_) => TextButton(
                                                              onPressed: _.isAgreeButtonValid.value? () {
                                                                  _.SignUp(context);
                                                              }:null,
                                                              child: Text("회원가입",
                                                                  style: _.isAgreeButtonValid==true ? inTextButton : inTextButtonDisabled),
                                                              style: _.isAgreeButtonValid==true ? textButtonStyle : textButtonStyleDisabled,
                                                            ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Container buildTop(String index, String title, Widget form) {
    return Container(
      height: Get.height * 0.85,
      width: Get.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.15),
          buildNumberContainer(index),
          SizedBox(height: 16),
          buildTitleText(title),
          SizedBox(height: 30),
          form,
        ],
      ),
    );
  }

  Container buildNumberContainer(String text) {
    return Container(
      alignment: Alignment.center,
      width: 55,
      height: 27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        color: feff,
      ),
      child: Text(text,
          style: TextStyle(fontSize: 14, color: mpBL, letterSpacing: 1)),
    );
  }

  Text buildTitleText(String text) {
    return Text(text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
    );
  }

  Column buildTitleText2(String text1, text2, text3) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
        ),
        Divider(thickness: 1, color: feff),
        SizedBox(height: Get.height*0.02),
        Text(text2,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(thickness: 1, color: feff),
        SizedBox(height: Get.height*0.02),
        Text(text3,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(thickness: 1, color: feff)
      ],
    );
  }

  Container buildNextButton(bool valid) {
    return Container(
        height: Get.height * 0.15,
        child: Column(
          children: [
            SizedBox(
              width: Get.width * 0.8,
              height: Get.height * 0.065,
              child: TextButton(
                onPressed: valid? () {
                  if (valid) {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                } : null,
                child: Text("다음으로", style: valid ? inTextButton : inTextButtonDisabled),
                style: valid ? textButtonStyle : textButtonStyleDisabled,
              ),
            ),
          ],
        ),
    );
  }
}
