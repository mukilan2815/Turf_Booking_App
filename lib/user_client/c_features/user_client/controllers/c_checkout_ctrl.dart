import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../c_common/c_payment/c_payment_tile.dart';
import '../models/payment_method_model.dart';


class CheckoutController extends GetxController{
   static CheckoutController get instance => Get.find();

   final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

   @override
   void onInit(){
      selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: KImages.paypal);
      super.onInit();
   }

   Future<dynamic> selectPaymentMethod(BuildContext context){
      return showModalBottomSheet(
          context: context,
          builder: (_) => SingleChildScrollView(
             child: Container(
                padding: const EdgeInsets.all(KSizes.lg),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      const KSectionHeading(title: "Selected Payment Method", showActionButton: false,),
                      const SizedBox(height: KSizes.spaceBtwSections,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: KImages.paypal)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: KImages.creditCard)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: KImages.googlePay)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: KImages.visa)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: KImages.masterCard)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      KPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: KImages.paytm)),
                      const SizedBox(height: KSizes.spaceBtwItems/2,),
                      const SizedBox(height: KSizes.spaceBtwSections,),
                   ],
                ),
             ),
          ),
      );
   }

   
}