import 'package:flutter/material.dart';
import '../../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../models/c_product_model.dart';

class KProductMetaData extends StatelessWidget {
  const KProductMetaData({super.key, required this.product});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    // final ctrl = ClientProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Title
        KProductTitleText(title:product.title),
        const SizedBox(height: KSizes.spaceBtwItems / 2,),

        /// Stock Status
        Wrap(
          children: [
            const KProductTitleText(title: 'No Hours:',),
            const SizedBox(width: KSizes.spaceBtwItems / 2),
            Text('1', style: Theme.of(context).textTheme.headlineMedium,),
          ],
        ),
        const SizedBox(height: KSizes.spaceBtwItems / 2,),

      ],
    );
  }
}
