import 'package:get/get.dart';
import 'package:turf_app/user_admin/a_features/user_admin/controllers/a_category_ctrl.dart';
import '../user_client/c_features/user_client/controllers/c_calendar.ctrl.dart';
import '../user_client/c_features/user_client/controllers/c_checkout_ctrl.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AdminCategoryController());
    Get.put(CheckoutController());
    Get.put(ClientCalendarController());


  }

}