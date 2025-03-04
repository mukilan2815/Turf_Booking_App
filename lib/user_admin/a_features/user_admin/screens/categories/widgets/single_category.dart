import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/a_category_ctrl.dart';
import '../../../models/a_category_model.dart';

class KSingleCategory extends StatelessWidget {
  const KSingleCategory({super.key, required this.category, this.onTap});

  final AdminCategoryModel category;
  final VoidCallback? onTap;



  @override
  Widget build(BuildContext context) {
    final ctrl = AdminCategoryController.instance;
    final dark = KHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedCategoryId = ctrl.selectedCategory.value.id;
      final selectedCategory = selectedCategoryId == category.id;
      return InkWell(
        onTap: onTap,
        child: KRoundedContainer(
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(KSizes.md),
          backgroundColor: KColors.primary,
          borderColor: dark ? KColors.darkerGrey : KColors.grey,
          margin: const EdgeInsets.only(bottom: KSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name, style: Theme.of(context).textTheme.headlineMedium!.apply(color: KColors.white),),
              const SizedBox(height: KSizes.sm),
              Text(category.id, style: Theme.of(context).textTheme.bodyLarge!.apply(color: KColors.white),),
            ],
          ),
        ),
      );
    });
  }
}
