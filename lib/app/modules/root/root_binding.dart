import 'package:folio/app/modules/profile/portfolio/portfolio_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_editing/team_editing_controller.dart';
import 'package:folio/app/modules/team/team_making/search_contest/search_contest_controller.dart';
import 'package:get/get.dart';
import 'package:folio/app/data/provider/api_provider.dart';
import 'package:folio/app/data/repository/repository.dart';
import 'package:folio/app/modules/contest/contest_controller.dart';
import 'package:folio/app/modules/contest/contest_detail/contest_detail_controller.dart';
import 'package:folio/app/modules/contest/contest_pages/bookmark_page_controller.dart';
import 'package:folio/app/modules/home/home_controller.dart';
import 'package:folio/app/modules/profile/profile_controller.dart';
import 'package:folio/app/modules/profile/profile_edit/profile_edit_controller.dart';
import 'package:folio/app/modules/team/team_controller.dart';
import 'package:folio/app/modules/team/team_detail/team_detail_controller.dart';
import 'package:folio/app/modules/team/team_making/team_making_controller.dart';
import 'root_controller.dart';
import 'package:http/http.dart' as http;

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );


    Get.lazyPut<HomeController>(() => HomeController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );


    Get.lazyPut<TeamController>(
      () => TeamController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<TeamDetailController>(
          () => TeamDetailController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<TeamEditingController>(
          () => TeamEditingController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<TeamMakingController>(
          () => TeamMakingController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<SearchContestController>(
          () => SearchContestController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );


    Get.lazyPut<ContestController>(
      () => ContestController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<ContestDetailController>(
          () => ContestDetailController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<BookmarkPageController>(
          () => BookmarkPageController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );


    Get.lazyPut<ProfileController>(
      () => ProfileController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<PortfolioController>(
          () => PortfolioController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );
    Get.lazyPut<ProfileEditController>(
          () => ProfileEditController(
        repository: MyRepository(
          apiProvider: MyApiProvider(httpClient: http.Client()),
        ),
      ),
    );


  }
}
