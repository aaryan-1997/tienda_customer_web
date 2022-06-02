import 'package:get/get.dart';
import 'package:tiendaweb/api/api_service.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/controllers/local_db_controller.dart';
import 'package:tiendaweb/controllers/location_controller.dart';
import 'package:tiendaweb/controllers/order_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/repository/auth_repo.dart';
import 'package:tiendaweb/repository/home_repo.dart';
import 'package:tiendaweb/repository/order_repo.dart';
import 'package:tiendaweb/repository/store_repo.dart';

Future<void> init() async {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));

  // repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find()));
  Get.lazyPut(() => StoreRepo(apiClient: Get.find()));
  Get.lazyPut(() => HomeRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => StoreController(storeRepo: Get.find()));
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  Get.lazyPut(() => LocationController());
  Get.lazyPut(() => LocalDbController());
}
