import 'package:get/get.dart';
import 'package:folio/app/data/provider/api_provider.dart';
import 'package:folio/app/data/repository/repository.dart';
import 'package:folio/app/modules/auth/auth_controller.dart';
import 'package:http/http.dart' as http;

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(
      repository: MyRepository(
        apiProvider: MyApiProvider(
          httpClient: http.Client(),
        ),
      ),
    )
    );
  }
}