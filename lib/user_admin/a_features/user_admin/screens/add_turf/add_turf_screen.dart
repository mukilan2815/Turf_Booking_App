import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../controllers/a_turf_ctrl.dart';
import 'widgets/add_turf_form.dart';

class AddTurfScreen extends StatelessWidget {
  const AddTurfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminTurfController());
    return Scaffold(
      /// -- items in cart
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            KPrimaryHeaderContainer(
                child: Column(
                  children: [
                    KAppBar(
                      title: Text('Add Turf Details',
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: KColors.white)),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems,),
                  ],
                )
            ),

            /// body
            Padding(
              padding: EdgeInsets.symmetric(horizontal :KSizes.defaultSpace,vertical: KSizes.xs),
              child: AddTurfForm(),
            ),
          ],
        ),
      ),

      /// -- checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal :KSizes.defaultSpace,vertical: 10),
        child: ElevatedButton(
            onPressed: () => ctrl.addTurf(),
            child:  Text('Add Turf',style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white))
        ),
      ),
    );
  }
}
