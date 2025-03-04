import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import 'shimmer.dart';

class KCategoryShimmer extends StatelessWidget {
  const KCategoryShimmer({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_,__) => const SizedBox(width: KSizes.spaceBtwItems,),
        itemBuilder: (_,__){
          return Padding(
            padding: const EdgeInsets.only(right: KSizes.sm ,top: KSizes.sm),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// text
                KShimmerEffect(width: 80, height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
