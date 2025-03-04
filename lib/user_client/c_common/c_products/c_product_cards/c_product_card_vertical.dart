import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/styles/shadows.dart';
import '../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../common/widgets/images/k_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../c_features/user_client/models/c_product_model.dart';
import '../../../c_features/user_client/screens/product_details/product_details.dart';


class KProductCardVertical extends StatelessWidget {
  const KProductCardVertical({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    //final  ctrl = ClientProductController.instance;
    final dark = KHelperFunctions.isDarkMode(context);
    /// Container with size paddings , color, edges, radius and shadow
    return GestureDetector(
      onTap: () => Get.to(()=>  ClientProductDetails(product: product,)),
      child: Container(
        width: 180,
        height: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [KShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(KSizes.productImageRadius),
          color: dark ? KColors.darkerGrey : KColors.white,
        ),
        child: Column(
          children: [
            /// product image and favorite icon
            KRoundedContainer (
              height: 160,
              backgroundColor: dark ? KColors.dark : KColors.light,
              child: Stack(
                children: [
                  /// Image
                  Padding(
                    padding:const EdgeInsets.all(KSizes.xs),
                    child: KRoundedImage(
                      imageurl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: KSizes.spaceBtwItems /4,),

            /// product details
             Padding(
              padding: const EdgeInsets.only(left: KSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// title of the product
                   KProductTitleText(title: product.title, smallSize: true,),

                ],
              ),
            ),


            const Spacer(),
            /// price and add cart icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// price
                Padding(
                  padding: const EdgeInsets.only(left: KSizes.sm),
                  child: KProductPriceText(price: product.price.toString()),
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}
