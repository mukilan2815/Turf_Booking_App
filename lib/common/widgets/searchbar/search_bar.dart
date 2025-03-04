import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class KSearchContainer extends StatelessWidget {
  const KSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    final dark = KHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
        child: Container(
          width: KDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: showBackground ? dark ? KColors.dark : KColors.light : Colors.transparent  ,
            borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: dark ? KColors.dark : KColors.white) : null ,
          ),
          child:  Row(
            children: [
              Icon(icon, color: dark ? KColors.light : KColors.dark,),
              const SizedBox(width: KSizes.spaceBtwItems,),
              Text(text,style:  Theme.of(context).textTheme.bodySmall!.apply(color: dark ? KColors.light : KColors.dark),)
            ],
          ),
        ),
      ),
    );
  }
}