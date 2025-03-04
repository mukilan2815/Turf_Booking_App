import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';
import 'shimmer.dart';

class KVerticalProductShimmer extends StatelessWidget {
  const KVerticalProductShimmer({
    super.key,
    this.itemCount =4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return KGridLayout(
        itemCount: itemCount,
        itemBuilder: (_,__) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              KShimmerEffect(width: 160, height: 160),
              SizedBox(height: KSizes.spaceBtwItems,),

              /// text
              KShimmerEffect(width: 160, height: 15),
            ],
          ),
        ),
    );
  }
}
