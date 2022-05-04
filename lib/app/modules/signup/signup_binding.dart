import 'package:get/get.dart';
import 'package:folio/app/modules/signup/signup_controller.dart';
import 'package:folio/app/data/provider/api_provider.dart';
import 'package:folio/app/data/repository/repository.dart';
import 'package:http/http.dart' as http;

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController(
        repository: MyRepository(
          apiProvider: MyApiProvider(
            httpClient: http.Client(),
          ),
        ),
      )
    );
  }
}
