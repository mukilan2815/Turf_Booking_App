import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/a_category_ctrl.dart';
import 'a_add_category.dart';
import 'widgets/single_category.dart';

class CategoriesDisplayScreen extends StatelessWidget {
  const CategoriesDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminCategoryController());
    return Scaffold(
      appBar: KAppBar(
        showBackArrow: true,
        title: Text(
          'Places', style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Obx(() {
          return FutureBuilder(
              key: Key(ctrl.refreshData.value.toString()),
              future: ctrl.adminFetchCategories(),
              builder: (context, snapshot) {
                final response = KCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                final categories = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) =>
                        KSingleCategory(category: categories[index],));
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KColors.primary,
        onPressed: () => Get.to(() => const AddNewCategoryScreen()),
        child: const Icon(Iconsax.add, color: KColors.white),
      ),
    );
  }
}
