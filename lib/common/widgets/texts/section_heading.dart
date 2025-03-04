import 'package:flutter/material.dart';
import 'package:turf_app/utils/constants/colors.dart';

class KSectionHeading extends StatelessWidget {
  const KSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = "View All",
    required this.title,
    this.showActionButton = true,
  });

  final Color? textColor;
  final bool showActionButton ;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if(showActionButton) TextButton(onPressed: onPressed, child:  Text(buttonTitle,style: TextStyle(color: KColors.primary),)),
      ],
    );
  }
}