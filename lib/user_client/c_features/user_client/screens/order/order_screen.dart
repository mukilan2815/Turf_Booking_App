import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import 'widgets/orders_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   KAppBar(title: Text('My Booking',style: Theme.of(context).textTheme.headlineMedium,),showBackArrow: true,),

      body: const Padding(
        padding: EdgeInsets.all(KSizes.defaultSpace),
        child: KOrdersListItems(),
      ),
    );
  }
}


