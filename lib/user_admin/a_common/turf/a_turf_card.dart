import 'package:flutter/material.dart';

import '../../../common/styles/shadows.dart';
import '../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../common/widgets/images/k_rounded_image.dart';
import '../../../common/widgets/texts/product_price_text.dart';
import '../../../common/widgets/texts/product_title_text.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../a_features/user_admin/models/a_turf_model.dart';

class AdminTurfCard extends StatelessWidget {
  const AdminTurfCard({super.key, required this.product});

  final AdminTurfModel product;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [KShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(KSizes.productImageRadius),
        color: dark ? KColors.dark : KColors.light,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// product image
          KRoundedContainer (
            height: 180,
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
                    //height: double.infinity,
                  ),
                ),
              ],
            ),
          ),


          /// product details
          Padding(
            padding: const EdgeInsets.only(left: KSizes.sm),
            /// title of the product
            child: KProductTitleText(title: product.title,),
          ),

          /// price
          Padding(
            padding: const EdgeInsets.only(left: KSizes.sm),
            child: KProductPriceText(price: product.price.toString()),
          ),
        ],
      ),

    );
  }
}
