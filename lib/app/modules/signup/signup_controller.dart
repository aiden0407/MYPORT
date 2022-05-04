import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folio/app/core/theme/app_widget_style.dart';
import 'package:folio/app/data/model/model.dart';
import 'package:folio/app/data/repository/repository.dart';

class SignUpController extends GetxController {
  final MyRepository repository;
  SignUpController({required this.repository}) : assert(repository != null);

  final _regionList = <MyRegionModel>[].obs;
  get regionList => this._regionList.value;
  set regionList(value) => this._regionList.value = value;
  List allRegion =[];
  getRegion() async {
    await repository.getRegion().then((data) {
      this.regionList = data;
    });
    for (int i = 0; i < regionList.length; i++) {
      allRegion.add(regionList[i].name);
    }
    update();
  }

  final _regionDetailList = <MyRegionDetailModel>[].obs;
  get regionDetailList => this._regionDetailList.value;
  set regionDetailList(value) => this._regionDetailList.value = value;
  List allRegionDetail =[];
  getRegionDetail(String code) async {
    await repository.getRegionDetail(code).then((data) {
      this.regionDetailList = data;
    });
    allRegionDetail =[];
    for (int i = 0; i < regionDetailList.length; i++) {
      allRegionDetail.add(regionDetailList[i].name.replaceAll(selectedDropdownRegion + " ", ''));
    }
    if(code=='11'){
      allRegionDetail.add('강북구');
      allRegionDetail.add('광진구');
      allRegionDetail.add('금천구');
    }
    selectedDropdownRegionDetail = allRegionDetail[0];
    update();
  }

  final _univList = <MyUnivModel>[].obs;
  get univList => this._univList.value;
  set univList(value) => this._univList.value = value;
  List allUniv = [];
  getUniv() async {
    await repository.getUniv().then((data) {
      this.univList = data;
    });
    for (int i = 0; i < univList.length; i++) {
      allUniv.add(univList[i].university_name);
    }
    update();
  }

  TextEditingController nameController = TextEditingController();
  var name = '';
  var isNameButtonValid = false.obs;
  void nameButtonValidator() {
    if (nameController.text.isNotEmpty) {
      isNameButtonValid = true.obs;
    } else {
      isNameButtonValid = false.obs;
    }
    update();
  }
  void saveName() {
    name = nameController.text;
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  var phone = '';
  var certificationCode = '';
  var isCertifyButtonValid = false.obs;
  var isInputCertificationValid = false.obs;
  var isPhoneButtonValid = false.obs;
  void certifyButtonValidator() {
    if (phoneController.text.length==11) {
      isCertifyButtonValid = true.obs;
    } else {
      isCertifyButtonValid = false.obs;
      isInputCertificationValid = false.obs;
      isPhoneButtonValid = false.obs;
    }
    update();
  }
  getPhone(String phone) {
    repository.getPhone(phone).then((data) {
      if (data!=null) {
        certificationCode = data;
        this.phone = phoneController.text;
        Get.snackbar('전화번호 인증', '인증번호가 발송되었습니다.');
        isInputCertificationValid = true.obs;
      } else {
        Get.snackbar('전화번호 인증 오류', '이미 등록된 전화번호입니다.');
        isInputCertificationValid = false.obs;
      }
      update();
    });
  }
  void phoneButtonValidator() {
    if (certificationController.text.length==5) {
      isPhoneButtonValid = true.obs;
    } else {
      isPhoneButtonValid = false.obs;
    }
    update();
  }

  TextEditingController birthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  var birth = '';
  var gender = '';
  var isBirthButtonValid = false.obs;
  void birthButtonValidator() {
    if (birthController.text.length==6 && genderController.text.length==1 &&
        int.parse(birthController.text.substring(2, 4)) > 0 &&
        int.parse(birthController.text.substring(2, 4)) <= 12 &&
        int.parse(birthController.text.substring(4)) > 0 &&
        int.parse(birthController.text.substring(4)) <= 31) {
      if(genderController.text=='1' || genderController.text=='3'){
        gender = 'male';
      } else gender = 'female';
      isBirthButtonValid = true.obs;
    } else {
      isBirthButtonValid = false.obs;
    }
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  var email = '';
  var password = '';
  var isEmailCertifyButtonValid = false.obs;
  var gotEmail = false.obs;
  var isEmailButtonValid = false.obs;
  void emailCertifyButtonValidator() {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
      isEmailCertifyButtonValid = true.obs;
    } else {
      isEmailCertifyButtonValid = false.obs;
    }
    gotEmail = false.obs;
    isEmailButtonValid = false.obs;
    update();
  }
  void getEmail(String data){
    repository.getEmail(data).then((result) {
      if (result == true) {
        email = emailController.text;
        gotEmail = true.obs;
        update();
        emailButtonValidator();
        return Get.snackbar('이메일 중복확인', '사용가능한 이메일입니다.');
      } else {
        gotEmail = false.obs;
        update();
        return Get.snackbar('이메일 인증 오류', '이미 사용중인 이메일입니다.');
      }
    });
  }
  void emailButtonValidator() {
    if (gotEmail==true &&
        passwordController.text.length >= 8 &&
        passwordController.text.length == passwordCheckController.text.length) {
      isEmailButtonValid = true.obs;
    } else {
      isEmailButtonValid = false.obs;
    }
    update();
  }

  var imageNull = true.obs;
  late File image;
  String imagePath='';

  TextEditingController univController = TextEditingController();
  var university = '';
  var isUnivFocused = false.obs;
  var isUnivButtonValid = false.obs;
  List resultsUniv = [];
  void univFocusOnValidator() {
    isUnivFocused = true.obs;
    update();
  }
  void univFocusOutValidator() {
    isUnivFocused = false.obs;
    update();
  }
  void univButtonValidator() {
    if (allUniv.contains(univController.text)) {
      isUnivButtonValid = true.obs;
    } else {
      isUnivButtonValid = false.obs;
    }
    update();
  }
  void runFilter(String text) {
    if (isUnivFocused==true) {
      if (text.isEmpty) {
        resultsUniv = allUniv;
      } else {
        resultsUniv = allUniv.where((univ) => univ.toLowerCase().contains(text.toLowerCase())).toList();
      }
    }
    update();
  }

  TextEditingController majorController = TextEditingController();
  var major = '';
  var isMajorFocused = false.obs;
  var isMajorButtonValid = false.obs;
  List allMajor = [];
  List resultsMajor = [];
  void majorFocusOnValidator() {
    isMajorFocused = true.obs;
    update();
  }
  void majorFocusOutValidator() {
    isMajorFocused = false.obs;
    update();
  }
  void majorButtonValidator() {
    if (allMajor.contains(majorController.text)) {
      isMajorButtonValid = true.obs;
    } else {
      isMajorButtonValid = false.obs;
    }
    update();
  }
  void runFilterMajor(String text) {
    if (isMajorFocused==true) {
      if (text.isEmpty) {
        resultsMajor = allMajor;
      } else {
        resultsMajor = allMajor.where((univ) => univ.toLowerCase().contains(text.toLowerCase())).toList();
      }
    }
    update();
  }
  List grades = [
    '22학번',
    '21학번',
    '20학번',
    '19학번',
    '18학번',
    '17학번',
    '16학번',
    '15학번',
    '14학번',
    '13학번',
    '12학번',
    '11학번',
    '10학번'
  ];
  var selectedDropdownGrade = '22학번';
  var selectedDropdownRegion = '서울특별시';
  var selectedDropdownRegionDetail = '종구로';
  List labels = [
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
  List selected = [
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
  var interest = '';
  var isInterestButtonValid = false.obs;
  void interestButtonValidator() {
    int count = 0;
    interest = '';
    for(int i=0; i < selected.length; i++){
      if (selected[i]) {
        count++;
        interest = interest + labels[i] + ' ';
      }
    }
    interest = interest.substring(0, interest.length - 1);
    if (count>=3) {
      isInterestButtonValid = true.obs;
    } else {
      isInterestButtonValid = false.obs;
    }
    update();
  }
  var isChecked1 = false;
  var isChecked2 = false;
  var isChecked3 = false;
  var isAgreeButtonValid = false.obs;
  void agreeButtonValidator() {
    if (isChecked1&&isChecked2) {
      isAgreeButtonValid = true.obs;
    } else {
      isAgreeButtonValid = false.obs;
    }
    update();
  }

  SignUp(context) async{
    var body = {
      "email": email,
      "password": password,
      "name": name,
      "birth_date": birth,
      "phone_number": phone,
      "address": selectedDropdownRegion+' '+selectedDropdownRegionDetail,
      "college": university,
      "major": major,
      "student_number": selectedDropdownGrade,
      "gender" : gender,
      "interest" : interest,
      "promotion" : isChecked3,
      "image" : imagePath
    };
    await repository.postSignUp(body).then((signup_result) async {
      if(signup_result){
        await repository.postLogIn(email, password).then((login_result) {
          if(login_result){
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) =>
                  Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  height: 140,
                  width: 70,
                  child: Center(
                    child: Column(
                      children: [
                        Text("회원가입 완료", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                        SizedBox(height: 10),
                        Text(name+"님의 회원가입을 진심으로 환영합니다", style: TextStyle(fontSize: 14)),
                        Expanded(child: Container()),
                        Divider(),
                        TextButton(
                          onPressed: (){
                            Get.offAllNamed('/');
                          },
                          child: Text("확인"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            GetDialog_GetOffAllNamed("회원가입 완료", "로그인을 진행해주십시오",'/auth');
          }
        });
      } else {
        GetDialog_GetOffAllNamed("회원가입 오류", "홈 화면으로 돌아가시겠습니까?",'/auth');
      }
    });
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