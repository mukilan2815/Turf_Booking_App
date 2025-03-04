import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../c_features/user_client/controllers/c_checkout_ctrl.dart';
import '../../c_features/user_client/models/payment_method_model.dart';

class KPaymentTile extends StatelessWidget {
  const KPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final ctrl = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        ctrl.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: KRoundedContainer(
        width: 60,
        height: 60,
        backgroundColor: KHelperFunctions.isDarkMode(context) ? KColors.light : KColors.white,
        padding: EdgeInsets.all(KSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain,),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
