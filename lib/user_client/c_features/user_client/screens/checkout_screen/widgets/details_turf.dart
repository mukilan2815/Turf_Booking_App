import 'package:flutter/material.dart';

import '../../../../../../common/widgets/images/k_rounded_image.dart';
import '../../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../models/c_product_model.dart';

class DetailsTurf extends StatelessWidget {
  const DetailsTurf({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        KRoundedImage(
          imageurl: product.thumbnail ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          //padding: const EdgeInsets.all(KSizes.sm),
          backgroundColor: KHelperFunctions.isDarkMode(context) ? KColors.darkerGrey : KColors.light,
        ),
        const SizedBox(width: KSizes.spaceBtwItems,),

        /// title & price
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: KProductTitleText(title: product.title, maxLines: 1,)),
              /// -- price
              Flexible(child: KProductPriceText(price: product.price.toString())),
            ],
          ),
        )
      ],
    );
  }
}
