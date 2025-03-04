import 'package:flutter/material.dart';

class KProductPriceText extends StatelessWidget {
  const KProductPriceText({
    super.key,
    required this.price,
    this.currencySign = '₹ ',
    this.hour = ' /hr',
    this.maxLines =1 ,
    this.isLarge = true,
    this.lineThrough = false,
  });

  final String currencySign, price,hour;
  final int maxLines;
  final bool isLarge ;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
    currencySign + price + hour,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
              ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
              :Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
