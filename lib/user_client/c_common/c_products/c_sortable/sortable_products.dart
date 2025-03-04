import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../c_features/user_client/controllers/c_all_products_ctrl.dart';
import '../../../c_features/user_client/models/c_product_model.dart';
import '../c_product_cards/c_product_card_vertical.dart';


class KSortableProducts extends StatelessWidget {
  const KSortableProducts({
    super.key, required this.products,
  });

  final List<ClientProductModel> products;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientAllProductsController());
    ctrl.clientAssignProducts(products);
    return Column(
      children: [

        /// dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: ctrl.selectedSortOption.value,
          onChanged: (value) {
            ctrl.clientSortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price']
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: KSizes.spaceBtwItems,),

        /// -- all products
        Obx(() => KGridLayout(
          itemCount: ctrl.products.length,
          itemBuilder: (_, index) => KProductCardVertical(product: ctrl.products[index],),
        )),
      ],
    );
  }
}
