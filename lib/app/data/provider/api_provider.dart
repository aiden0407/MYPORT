import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:folio/app/data/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = 'https://myport-server.link';
final String regionUrl = 'https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes?regcode_pattern=';


class MyApiProvider {
  final http.Client httpClient;
  MyApiProvider({required this.httpClient});

  getRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    accessToken = '_';
    String refreshToken = (prefs.getString('refreshToken')??'_');
    print(accessToken+'/'+refreshToken);
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/user/refresh'),
          headers: {
            'authorization' : 'Bearer $accessToken',
            'refresh' : refreshToken
          }
      );
      print(response.statusCode.toString()+response.body.toString());
      if(response.statusCode==200){
        //accessToken expired
        var token = jsonDecode(utf8.decode(response.bodyBytes))['token'];
        await prefs.setString('accessToken',token['accessToken']);
        return '/root';
      } else if (response.statusCode==400) {
        //accessToken not expired
        return '/root';
      } else if (response.statusCode==401) {
        //accessToken not exist
        return '/auth';
      } else {
        //503:server error
        return '/auth';
        //return '/root';
      }
    } catch (_) {
      print(_);
    }
  }
  postSignUp(body) async {
    var dio = new Dio();
    var formData;
    if (body["image"]==''){
      print("case: 0");
      formData  = FormData.fromMap({
        'email' : body["email"],
        'password' : body["password"],
        'name' :  body["name"],
        'birth_date' : body["birth_date"],
        'phone_number' : body["phone_number"],
        'address' : body["address"],
        'college' : body["college"],
        'major' : body["major"],
        'student_number' : body["student_number"],
        'gender' : body["gender"],
        'interest' : body["interest"],
      });
    } else {
      print("case: 0 with image");
      formData  = FormData.fromMap({
        'email' : body["email"],
        'password' : body["password"],
        'name' :  body["name"],
        'birth_date' : body["birth_date"],
        'phone_number' : body["phone_number"],
        'address' : body["address"],
        'college' : body["college"],
        'major' : body["major"],
        'student_number' : body["student_number"],
        'gender' : body["gender"],
        'interest' : body["interest"],
        'image': await MultipartFile.fromFile(body["image"], filename: "profile.jpg"),
      });
    }
    try {
      dio.options.contentType = 'multipart/form-data';
      var response = await dio.post(baseUrl+'/api/user', data: formData);
      String userID = response.data['user_id'];
      if (response.statusCode == 201) {
        await http.post(Uri.parse(baseUrl + '/api/profile/'+ userID));
        await http.post(Uri.parse(baseUrl + '/api/profile/portfolio/'+ userID));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  postLogIn(email, password) async {
    try {
      var data = {
        "email" : email,
        "password" : password
      };
      var body = json.encode(data);
      http.Response response = await http.post(Uri.parse(baseUrl+'/api/user/token'), headers: {"Content-Type": "application/json"}, body: body);
      print(response.statusCode.toString()+response.body.toString());
      if (response.statusCode==200) {
        var token = jsonDecode(utf8.decode(response.bodyBytes))['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken',token['accessToken']);
        await prefs.setString('refreshToken',token['refreshToken']);
        return true;
      } else {
        return false;
      }
    } catch (_) {}
  }


  getFindEmail(String name, String birth) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/user/find/email?name='+name+'&birth_date='+birth),
      );
      if(response.statusCode==200){
        //email exist
        var email = jsonDecode(utf8.decode(response.bodyBytes))['email'];
        return email;
      } else if (response.statusCode==400) {
        //email not exist
        return 'email not exist';
      } else {
        //server error
        return 'server error';
      }
    } catch (_) {}
  }
  getResetPassword(String email) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/user/send/email/'+email),
      );
      return response.statusCode;
    } catch (_) {}
  }


  getRegion() async {
    try {
      var response = await httpClient.get(Uri.parse(regionUrl+'*00000000'));
      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['regcodes'];
        List<MyRegionModel> listMyModel = jsonResponse.map((model) => MyRegionModel.fromJson(model)).toList();
        return listMyModel;
      } else
        print('error');
    } catch (_) {}
  }
  getRegionDetail(String code) async {
    try {
      var response = await httpClient.get(Uri.parse(regionUrl+code+'*000000&is_ignore_zero=true'));
      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['regcodes'];
        List<MyRegionDetailModel> listMyModel = jsonResponse.map((model) => MyRegionDetailModel.fromJson(model)).toList();
        return listMyModel;
      } else
        print('error');
    } catch (_) {}
  }
  getUniv() async {
    try {
      var response = await httpClient.get(Uri.parse(baseUrl+'/api/user/university'));
      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(utf8.decode(response.bodyBytes))['university'];
        List<MyUnivModel> listMyModel = jsonResponse.map((model) => MyUnivModel.fromJson(model)).toList();
        return listMyModel;
      } else
        print('error');
    } catch (_) {}
  }
  getPhone(String phone) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/user/phone/' + phone));
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))['number'].toString();
      } else {
        //response.statusCode == 400 / already used phoneNum
        return null;
      }
    } catch (_) {}
  }
  getEmail(String email) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/user/email/exist/' + email));
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (_) {}
  }


  getHome() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/home'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print("getHome"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }


  getTeam() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/team'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print("getTeam"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {print(_);}
  }
  getTeamDetail(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/team/'+teamId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['team'];
      } else {
        print(response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {print(_);}
  }
  postTeamMaking(int type, body) async {
    var dio = new Dio();
    var formData;
    if(type==0) {
      if (body["image"]==''){
        print("case: 0");
        formData = FormData.fromMap({
          "team_name" : body["team_name"],
          "short_explanation" : body["short_explanation"],
          "detail_explanation" : body["detail_explanation"],
          "recruitment_field" : body["recruitment_field"],
          "team_type" : body["team_type"],
          "gender" : body["gender"],
        });
      } else {
        print("case: 0 with image");
        formData = FormData.fromMap({
          "team_name" : body["team_name"],
          "short_explanation" : body["short_explanation"],
          "detail_explanation" : body["detail_explanation"],
          "recruitment_field" : body["recruitment_field"],
          "team_type" : body["team_type"],
          "gender" : body["gender"],
          "image": await MultipartFile.fromFile(body["image"], filename: "team_thumbnail.jpg"),
        });
      }
    } else if(type==1) {
      print("case: 1");
      formData = FormData.fromMap({
        "team_name" : body["team_name"],
        "short_explanation" : body["short_explanation"],
        "detail_explanation" : body["detail_explanation"],
        "recruitment_field" : body["recruitment_field"],
        "team_type" : "공모전/해커톤",
        "gender" : body["gender"],
        "relation_contest" : body["contest_id"],
      });
    } else {
      print("case: 2");
      formData = FormData.fromMap({
        "team_name" : body["team_name"],
        "short_explanation" : body["short_explanation"],
        "detail_explanation" : body["detail_explanation"],
        "recruitment_field" : body["recruitment_field"],
        "team_type" : "대외활동",
        "gender" : body["gender"],
        "relation_extracurricular" : body["extracurricular_id"],
      });
    }
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.headers['authorization'] = 'Bearer $accessToken';
      print(formData.toString());
      var response = await dio.post(baseUrl+'/api/team', data: formData);
      print(response.statusCode.toString()+response.data.toString());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print("e.requestOptions.contentType: " + e.requestOptions.contentType.toString());
      print("e.requestOptions.headers: " + e.requestOptions.headers.toString());
      print("e.requestOptions.data: " + e.requestOptions.data.toString());
      print("e.response: " + e.response.toString());
      return false;
    }
  }
  putTeamEdit(String teamId, int type, body) async {
    var dio = new Dio();
    var formData;
    print(body);
    if(type==0) {
      if (body["image"]==''){
        print("case: 0");
        formData = FormData.fromMap({
          "team_name" : body["team_name"],
          "short_explanation" : body["short_explanation"],
          "detail_explanation" : body["detail_explanation"],
          "recruitment_field" : body["recruitment_field"],
          "team_type" : body["team_type"],
          "gender" : body["gender"],
        });
      } else {
        print("case: 0 with image");
        formData = FormData.fromMap({
          "team_name" : body["team_name"],
          "short_explanation" : body["short_explanation"],
          "detail_explanation" : body["detail_explanation"],
          "recruitment_field" : body["recruitment_field"],
          "team_type" : body["team_type"],
          "gender" : body["gender"],
          "image": await MultipartFile.fromFile(body["image"], filename: "team_thumbnail.jpg"),
        });
      }
    } else if(type==1) {
      print("case: 1");
      formData = FormData.fromMap({
        "team_name" : body["team_name"],
        "short_explanation" : body["short_explanation"],
        "detail_explanation" : body["detail_explanation"],
        "recruitment_field" : body["recruitment_field"],
        "team_type" : "공모전/해커톤",
        "gender" : body["gender"],
        "relation_contest" : body["contest_id"],
      });
    } else {
      print("case: 2");
      formData = FormData.fromMap({
        "team_name" : body["team_name"],
        "short_explanation" : body["short_explanation"],
        "detail_explanation" : body["detail_explanation"],
        "recruitment_field" : body["recruitment_field"],
        "team_type" : "대외활동",
        "gender" : body["gender"],
        "relation_extracurricular" : body["extracurricular_id"],
      });
    }
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.headers['authorization'] = 'Bearer $accessToken';
      var response = await dio.put(baseUrl+'/api/team/'+teamId, data: formData);
      print(response.statusCode.toString()+response.data.toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print("e.requestOptions.contentType: " + e.requestOptions.contentType.toString());
      print("e.requestOptions.headers: " + e.requestOptions.headers.toString());
      print("e.requestOptions.data: " + e.requestOptions.data.toString());
      print("e.response: " + e.response.toString());
      return false;
    }
  }
  deleteTeam(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.delete(Uri.parse(baseUrl + '/api/team/'+teamId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      print(response.statusCode.toString()+response.body.toString());
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }
  patchTeamEditRecruit(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.patch(Uri.parse(baseUrl + '/api/team/recruitment/'+teamId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }
  patchTeamAccept(String teamId, String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.patch(Uri.parse(baseUrl + '/api/team/accept/'+teamId+'/'+memberId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }
  patchTeamRefuse(String teamId, String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.patch(Uri.parse(baseUrl + '/api/team/refuse/'+teamId+'/'+memberId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }
  patchTeamApply(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.patch(Uri.parse(baseUrl + '/api/team/apply/'+teamId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }
  deleteTeamLeave(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.delete(Uri.parse(baseUrl + '/api/team/secession/'+teamId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      print(response.statusCode.toString()+response.body.toString());
      if(response.statusCode==200){
        return true;
      } else {
        return false;
      }
    } catch (_) {return false;}
  }


  getContest() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/activity/contests'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['contests'];
      } else {
        print("getContest"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  getContestDetail(String contestId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/activity/contest/'+contestId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['contest'];
      } else {
        print(response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  postContestBookmark(String contestId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var data = {
        "contest_id" : contestId,
      };
      var body = json.encode(data);
      http.Response response = await http.post(Uri.parse(baseUrl+'/api/activity/contest/interest'),
          headers: {
            "authorization": "Bearer $accessToken",
            "Content-Type": "application/json"
          },
          body: body);
      if (response.statusCode==201) {
        return true;
      } else {
        return false;
      }
    } catch (_) {}
  }
  deleteContestBookmark(String contestId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      http.Response response = await http.delete(Uri.parse(baseUrl+'/api/activity/contest/interest/'+contestId),
          headers: {
            'authorization' : 'Bearer $accessToken'
          });
      // print(response.request.toString());
      // print(contestId);
      // print(response.statusCode.toString()+response.body.toString());
      if (response.statusCode==200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {}
  }


  getOutdoor() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/activity/extracurriculars'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['extracurriculars'];
      } else {
        print("getOutdoor"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  getOutdoorDetail(String outdoorId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/activity/extracurricular/'+outdoorId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['response_extracurricular'];
      } else {
        print(response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  postOutdoorBookmark(String outdoorId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var data = {
        "extracurricular_id" : outdoorId,
      };
      var body = json.encode(data);
      http.Response response = await http.post(Uri.parse(baseUrl+'/api/activity/extracurricular/interest'),
          headers: {
            "authorization": "Bearer $accessToken",
            "Content-Type": "application/json"
          },
          body: body);
      if (response.statusCode==201) {
        return true;
      } else {
        return false;
      }
    } catch (_) {}
  }
  deleteOutdoorBookmark(String outdoorId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      http.Response response = await http.delete(Uri.parse(baseUrl+'/api/activity/extracurricular/interest/'+outdoorId),
          headers: {
            'authorization' : 'Bearer $accessToken'
          });
      if (response.statusCode==200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {}
  }


  getProfileMy() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/profile/my'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['profile'];
      } else {
        print("getProfile"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  getPortfolioMy() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/profile/portfolio/my'),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['portfolio'];
      } else {
        print("getProfile"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  getProfileOther(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/profile/'+userId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['profile'];
      } else {
        print("getProfile"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }
  getPortfolioOther(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = (prefs.getString('accessToken')??'_');
    try {
      var response = await http.get(Uri.parse(baseUrl + '/api/profile/portfolio/'+userId),
          headers: {
            'authorization' : 'Bearer $accessToken',
          }
      );
      if(response.statusCode==200){
        return jsonDecode(utf8.decode(response.bodyBytes))['portfolio'];
      } else {
        print("getProfile"+response.statusCode.toString()+response.body.toString());
      }
    } catch (_) {}
  }

}