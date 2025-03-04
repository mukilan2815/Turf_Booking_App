import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class KGridLayout extends StatelessWidget {
  const KGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisEvent = 210,
  });

  final int itemCount;
  final double? mainAxisEvent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: KSizes.gridViewSpacing,
        crossAxisSpacing: KSizes.gridViewSpacing,
        mainAxisExtent: mainAxisEvent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
