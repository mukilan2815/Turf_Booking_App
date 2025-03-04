import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../controllers/c_order_ctrl.dart';
import '../../models/c_product_model.dart';
import 'widgets/billing_payment_section.dart';
import 'widgets/calendar_section.dart';
import 'widgets/details_turf.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {

    final orderCtrl = Get.put(ClientOrderController());
    final dark = KHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KAppBar(showBackArrow: true,title: Text('Booking', style: Theme.of(context).textTheme.headlineMedium,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              /// -- items in cart

              DetailsTurf(product: product,),
              const SizedBox(height: KSizes.spaceBtwSections,),

              /// -- billing section
              KRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(KSizes.md),
                backgroundColor: dark ? KColors.black: KColors.white,
                borderColor: dark ? KColors.darkerGrey: KColors.grey,
                child: Column(
                  children: [

                    KCalendarSection(),
                    SizedBox(height: KSizes.spaceBtwItems,),
                    /// -- divider
                    Divider(),
                    SizedBox(height: KSizes.spaceBtwItems,),

                    /// -- payment methods
                    KBillingPaymentSection(),
                    SizedBox(height: KSizes.spaceBtwItems,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => orderCtrl.processOrder(product.price,product),

            child: Text('Checkout ₹ ${product.price}',
                style: Theme.of(context).textTheme.headlineMedium!.apply(color: KColors.white))
        ),
      ),
    );
  }
}


