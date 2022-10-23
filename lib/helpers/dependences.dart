import 'package:dashboard_feirapp/helpers/shared_pref.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../controllers/auth/login_controller.dart';
import '../controllers/menu_controller.dart';
import '../controllers/navigation_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/login_repo.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => LoginRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => LoginController(loginRepo: Get.find()));

  Get.put(MenuController());
  Get.put(NavigationController());
}
