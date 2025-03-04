
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../common/widgets/custom_shapes/product_container/product_rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../controllers/a_turf_ctrl.dart';
import 'add_category_section.dart';


class AddTurfForm extends StatelessWidget {
  const AddTurfForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminTurfController());
    final dark = KHelperFunctions.isDarkMode(context);
    return SingleChildScrollView(
      child: Form(
        key: ctrl.turfFormKey,
        child: Column(
          children: [
            /// product image
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Turf Image', style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Image Source',),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading:
                                const Icon(
                                  Icons.photo_library, color: KColors.primary,),
                                title: Text('Gallery',),
                                onTap: () {
                                  ctrl.uploadTurfImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Obx(() {
                    return Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: KColors.primary),
                      ),
                      child: ctrl.thumbnail.value != null
                          ? Image.file(ctrl.thumbnail.value!,
                        fit: BoxFit.cover,)
                          : const Icon(
                        Icons.add_a_photo, color: KColors.primary, size: 40,),
                    );
                  }),
                ),
                const SizedBox(height: 16.0),
              ],
            ),

            /// product name
            TextFormField(
              controller: ctrl.title,
              validator: (value) =>
                  KValidator.validateEmptyText('Title', value),
              decoration: const InputDecoration(
                labelText: KTexts.turfTitle,
                prefixIcon: Icon(Icons.shopping_bag),),
            ),
            const SizedBox(height: KSizes.spaceBtwInputFields,),

            /// price
            TextFormField(
              controller: ctrl.price,
              validator: (value) =>
                  KValidator.validateEmptyText('Price/hr', value),
              decoration: const InputDecoration(
                labelText: KTexts.turfPrice,
                prefixIcon: Icon(Icons.paid_rounded),),
            ),
            const SizedBox(height: KSizes.spaceBtwInputFields,),

            /// product name
            TextFormField(
              controller: ctrl.players,
              validator: (value) =>
                  KValidator.validateEmptyText('No of Players', value),
              decoration: const InputDecoration(
                labelText: KTexts.turfPlayers,
                prefixIcon: Icon(Icons.person),),
            ),
            const SizedBox(height: KSizes.spaceBtwInputFields,),

            /// address
            TextFormField(
              controller: ctrl.address,
              validator: (value) =>
                  KValidator.validateEmptyText('Address', value),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: KTexts.turfAddress,
                prefixIcon: Icon(Icons.location_on),),
            ),
            const SizedBox(height: KSizes.spaceBtwInputFields,),

            /// category
            KRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.symmetric(
                  vertical: KSizes.xs, horizontal: KSizes.md),
              backgroundColor: Colors.transparent,
              borderColor: dark ? KColors.darkerGrey : KColors.grey,
              child: KAddCategorySection(),
            ),

            const SizedBox(height: KSizes.spaceBtwInputFields,),

          ],
        ),
      ),
    );
  }
}
