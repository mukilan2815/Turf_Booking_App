import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../../c_features/user_client/controllers/c_category_ctrl.dart';
import '../../c_features/user_client/screens/sub_category_screen/sub_category.dart';



/// categories Body
class KCategoriesBody extends StatelessWidget {
  const KCategoriesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryCtrl = Get.put(ClientCategoryController());
    return Obx(() {
      if (categoryCtrl.isLoading.value) return const KCategoryShimmer();

      if (categoryCtrl.clientFeaturedCategories.isEmpty) {
        return Center(child: Text('No Data Found!',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryCtrl.clientFeaturedCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category =categoryCtrl.clientFeaturedCategories[index];
            return KVerticalShowOption(
              title: category.name,
              onTap: () => Get.to(() => SubCategoryScreen(category : category)),
            );
          },
        ),
      );
    });
  }
}


/// vertical show option for categories
class KVerticalShowOption extends StatelessWidget {
  const KVerticalShowOption({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: KSizes.sm),
        child: SizedBox(
          child: Chip(
            label: Text(title,style: Theme.of(context).textTheme.headlineSmall,),
            labelStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

