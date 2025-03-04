import 'package:flutter/material.dart';
import '../../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/c_product/c_product_ctrl.dart';
import '../../../models/c_product_model.dart';

class KProductAttribute extends StatelessWidget {
  const  KProductAttribute({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    final ctrl = ClientProductController.instance;
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Attribute price and description
        KRoundedContainer(
          padding: const EdgeInsets.all(KSizes.md),
          backgroundColor: dark ? KColors.darkerGrey: KColors.grey,
          child: Column(
            children: [
              /// title , price and stock status
              Row(
                children: [
                  const KSectionHeading(title: 'Variation',showActionButton: false,),
                  const SizedBox(width: KSizes.spaceBtwItems,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// price
                      Row(
                        children: [
                          const KProductTitleText(title: 'Price: ',),
                          const SizedBox(width: KSizes.spaceBtwItems,),
                          /// price
                          KProductPriceText(price: product.price.toString()),
                        ],
                      ),
                      /// stock
                      Row(
                        children: [
                          const KProductTitleText(title: 'Players: '),
                          const SizedBox(width: KSizes.spaceBtwItems,),
                          Text(product.players.toString(),style: Theme.of(context).textTheme.headlineMedium,)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
