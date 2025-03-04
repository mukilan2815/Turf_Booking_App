import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class KLoginHeader extends StatelessWidget {
  const KLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          height: 150,
          image: dark ? AssetImage(KImages.lightAppLogo):AssetImage(KImages.darkAppLogo),
        ),
        Text(KTexts.appName,style: Theme.of(context).textTheme.headlineLarge,),
        const SizedBox(height: KSizes.sm,),
        Text(KTexts.loginTitle,style: Theme.of(context).textTheme.headlineLarge,)
      ],
    );
  }
}