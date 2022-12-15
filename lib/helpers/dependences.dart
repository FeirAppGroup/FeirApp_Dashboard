import 'package:dashboard_feirapp/controllers/model_controller/inventory_controller.dart';
import 'package:dashboard_feirapp/controllers/model_controller/order_controller.dart';
import 'package:dashboard_feirapp/controllers/model_controller/product_controller.dart';
import 'package:dashboard_feirapp/controllers/model_controller/property_controller.dart';
import 'package:dashboard_feirapp/controllers/model_controller/user_controller.dart';
import 'package:dashboard_feirapp/data/repository/inventory_repo.dart';
import 'package:dashboard_feirapp/data/repository/order_repo.dart';
import 'package:dashboard_feirapp/data/repository/product_repo.dart';
import 'package:dashboard_feirapp/data/repository/property_repo.dart';
import 'package:dashboard_feirapp/data/repository/user_repo.dart';
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
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => PropertyRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => InventoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => LoginController(loginRepo: Get.find()));
  Get.put(UserController(userRepo: Get.find()));
  Get.put(PropertyController(propertyRepo: Get.find()));
  Get.put(ProductController(productRepo: Get.find()));
  Get.put(InventoryController(inventoryRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  Get.put(MenuController());
  Get.put(NavigationController());
}
