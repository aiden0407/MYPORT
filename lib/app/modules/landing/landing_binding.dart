import 'package:get/get.dart';
import 'package:folio/app/data/provider/api_provider.dart';
import 'package:folio/app/data/repository/repository.dart';
import 'package:folio/app/modules/landing/landing_controller.dart';
import 'package:http/http.dart' as http;

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LandingController>(LandingController(
      repository: MyRepository(
        apiProvider: MyApiProvider(
          httpClient: http.Client(),
        ),
      ),
    )
    );
  }
}
