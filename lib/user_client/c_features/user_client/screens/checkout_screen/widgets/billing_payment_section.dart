import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/c_checkout_ctrl.dart';

class KBillingPaymentSection extends StatelessWidget {
  const KBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = CheckoutController.instance;
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        KSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => ctrl.selectPaymentMethod(context),
        ),

        const SizedBox(height: KSizes.spaceBtwItems / 2,),

        Obx(() {
          return Row(
            children: [
              KRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? KColors.black : KColors.white,
                padding: const EdgeInsets.all(KSizes.sm),
                child: Image(image: AssetImage(ctrl.selectedPaymentMethod.value.image), fit: BoxFit.contain,),
              ),

              const SizedBox(width: KSizes.spaceBtwItems / 2,),

              Text(ctrl.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge,)
            ],
          );
        })
      ],
    );
  }
}
