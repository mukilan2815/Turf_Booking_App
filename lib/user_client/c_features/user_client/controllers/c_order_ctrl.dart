import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu/client_user_navigation/client_navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../c_data/c_repositories/c_authentication/c_authentication_repository.dart';
import '../../../c_data/c_repositories/c_order/c_order_repository.dart';
import '../models/c_order_model.dart';
import '../models/c_product_model.dart';
import 'c_calendar.ctrl.dart';
import 'c_checkout_ctrl.dart';

class ClientOrderController extends GetxController {
  static ClientOrderController get instance => Get.find();

  final checkoutCtrl = CheckoutController.instance;
  final clientOrderRepository = Get.put(ClientOrderRepository());
  final calendarCtrl = Get.put(ClientCalendarController());

  Future<List<ClientOrderModel>> clientFetchUserOrders() async {
    try {
      final userOrders = await clientOrderRepository.clientFetchUserOrders();
      return userOrders;
    } catch (e) {
      KLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount, ClientProductModel turf) async {
    try {
      KFullScreenLoader.openLoadingDialog(
          'Processing your booking', KImages.pencilAnimation);
      final userId = AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      if (userId.isEmpty) return;
      String orderDate = KHelperFunctions.getFormattedDate(calendarCtrl.date);

      final order = ClientOrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        totalAmount: totalAmount,
        orderDate: orderDate,
        paymentMethod: checkoutCtrl.selectedPaymentMethod.value.name,
        items: turf,
      );

      await clientOrderRepository.clientSaveOrder(order, userId);
      KFullScreenLoader.stopLoading();

      Get.offAll(() => SuccessScreen(
            image: KImages.successfulPaymentIcon,
            title: 'Payment Success!',
            subTitle: 'Turf is booked!',
            onPressed: () => Get.offAll(() => const ClientNavigationMenu()),
          ));
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      KFullScreenLoader.openLoadingDialog(
          'Cancelling your booking', KImages.pencilAnimation);
      final userId = AuthenticationRepositoryClient.instance.clientAuthUser!.uid;
      if (userId.isEmpty) throw 'User not authenticated';

      await clientOrderRepository.clientCancelOrder(orderId, userId);

      KFullScreenLoader.stopLoading();
      KLoaders.successSnackBar(
        title: 'Booking Cancelled',
        message: 'Your booking #$orderId has been successfully cancelled.',
      );
      update();
    } catch (e) {
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'Cancellation Failed', message: e.toString());
    }
  }
}