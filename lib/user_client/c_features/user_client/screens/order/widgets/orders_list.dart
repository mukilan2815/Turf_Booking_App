// lib/user_client/c_features/user_client/screens/order/widgets/orders_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../../navigation_menu/client_user_navigation/client_navigation_menu.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/c_order_ctrl.dart';

class KOrdersListItems extends StatelessWidget {
  const KOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientOrderController());
    final dark = KHelperFunctions.isDarkMode(context);

    return FutureBuilder(
      future: ctrl.clientFetchUserOrders(),
      builder: (_, snapshot) {
        final emptyWidget = KAnimationLoaderWidget(
          text: 'Whoops! No orders Yet!',
          animation: KImages.orderCompletedAnimation,
          showAction: true,
          actionText: "Let's fill it",
          onActionPressed: () => Get.offAll(() => const ClientNavigationMenu()),
        );

        final response = KCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: KSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            final isCancellable = order.status == 'confirmed';

            return KRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(KSizes.md),
              backgroundColor: dark ? KColors.dark : KColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(width: KSizes.spaceBtwItems / 2),
                          Text(
                            'Order #${order.id}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.arrow_right_34, size: KSizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: KSizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: KSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order ID', style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.id, style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: KSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Booking Date', style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.orderDate, style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isCancellable) ...[
                    const SizedBox(height: KSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => _cancelBooking(context, ctrl, order.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(horizontal: KSizes.lg),
                          ),
                          child: const Text('Cancel Booking'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _cancelBooking(BuildContext context, ClientOrderController ctrl, String orderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel booking #$orderId?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ctrl.cancelOrder(orderId);
                Navigator.pop(context);
                // No additional snackbar here; handled in cancelOrder
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to cancel booking: $e')),
                );
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}