import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../models/c_product_model.dart';
import '../checkout_screen/checkout_screen.dart';
import 'widgets/product_attribute.dart';
import 'widgets/product_details_image.dart';
import 'widgets/product_meta_data.dart';

class ClientProductDetails extends StatelessWidget {
  const ClientProductDetails({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product image and icons
            KProductImage(product: product,),

            /// Product details
            Padding(
                padding: const EdgeInsets.only(right: KSizes.defaultSpace,left: KSizes.defaultSpace,bottom: KSizes.defaultSpace),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///  - Price
                  KProductMetaData(product: product,),

                  /// - attribute
                  KProductAttribute(product: product,),
                  const SizedBox(height: KSizes.spaceBtwSections,),

                  ///  - Address
                  const KSectionHeading(title: 'Address',showActionButton: false ,),
                  const SizedBox(height: KSizes.spaceBtwItems,),
                   ReadMoreText(
                      product.address ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Length,
                    textAlign: TextAlign.justify,
                    trimCollapsedText: " Show more" ,
                    trimExpandedText: "Less",
                    moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: KSizes.spaceBtwSections,),

                  ///  - Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Get.to( CheckoutScreen(product: product,)),
                        child:  Text('Checkout',style: Theme.of(context).textTheme.headlineMedium,)
                    ),
                  ),
                ],
              ) ,
            ),

          ],
        ),
      ),
    );
  }
}


