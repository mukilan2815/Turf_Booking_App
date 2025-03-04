import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed
  });

  final String image,title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: KSpacingStyle.paddingWithAppBarHeight *2,
          child: Column(
            children: [
              /// -- image
              Image(image: AssetImage(image),width: KHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: KSizes.spaceBtwSections,),

              /// -- title & subtitle
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: KSizes.spaceBtwItems,),
              Text(subTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: KSizes.spaceBtwSections,),

              /// -- buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: onPressed, child:  Text(KTexts.tContinue,style: Theme.of(context).textTheme.headlineMedium)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
