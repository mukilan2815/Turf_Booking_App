import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../controllers/a_category_ctrl.dart';



class KAddCategorySection extends StatelessWidget {
  const KAddCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCtrl = AdminCategoryController.instance;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KSectionHeading(
            title: 'Turf Places',
            buttonTitle: 'Choose',
            onPressed: () => categoryCtrl.selectNewCategoryPopup(context),
          ),
          if (categoryCtrl.selectedCategory.value.id.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(categoryCtrl.selectedCategory.value.name,
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: KColors.primary),),
                  ],
                ),
              ],
            )
          else
            Text("Select Turf Place", style: Theme.of(context).textTheme.bodyMedium,)
        ],
      );
    });
  }
}
