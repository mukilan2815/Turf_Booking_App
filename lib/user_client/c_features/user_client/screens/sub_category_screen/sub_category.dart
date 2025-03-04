import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../c_common/c_products/c_sortable/sortable_products.dart';
import '../../controllers/c_category_ctrl.dart';
import '../../models/c_category_model.dart';


class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final ClientCategoryModel category;
  @override
  Widget build(BuildContext context) {
    final ctrl = ClientCategoryController.instance;
    return Scaffold(
      appBar: KAppBar(title: Text(category.name,style: Theme.of(context).textTheme.headlineMedium,),showBackArrow: true,),

      /// -- sub-category
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(KSizes.defaultSpace),
          child: FutureBuilder(
              future: ctrl.clientGetCategoriesProducts(category.id),
              builder: ( context,  snapshot) {
                const loader = KVerticalProductShimmer(itemCount: 6,);
                final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if (widget != null) return widget;

                final products =snapshot.data!;
                return KSortableProducts(products: products);
              },
          ),
        ),
      ),
    );
  }
}

/*Column(
            children: [
              /// -- sub-category
              KGridLayout(
                itemCount: 4,
                itemBuilder: (context,index) => const KProductCardVertical(),
              ),
            ],
          ),*/

/*ListView.builder(
                itemCount: 4,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => const KProductCardVertical(),
              ),*/
