import 'package:get/get.dart';
import 'package:folio/app/data/repository/repository.dart';

class ProfileController extends GetxController {
  final MyRepository repository;
  ProfileController({required this.repository}) : assert(repository != null);


  var image;
  String name = '';
  String status = '';
  String intro = '';
  String grade = '';
  String job = '';
  var sns;


  getProfile() async {
    await repository.getProfileMy().then((data) {
      name = data['user']['name'];
    });
    update();
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
