import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../c_common/c_products/c_sortable/sortable_products.dart';
import '../../controllers/c_all_products_ctrl.dart';
import '../../models/c_product_model.dart';



class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod
  });

  final String title;
  final Query? query;
  final Future<List<ClientProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientAllProductsController());
    return Scaffold(
      appBar: KAppBar(title: Text(title,style: Theme.of(context).textTheme.headlineMedium,),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? ctrl.clientFetchProductsByQuery(query),
            builder: (context,snapshot) {
              // check the state of future builder
              const loader = KVerticalProductShimmer();
              final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);

              // return appropriate widget based on snapshot state
              if(widget != null) return widget;
              // Products found
              final products = snapshot.data!;

              return KSortableProducts(products: products,);
              },
          ),
        ),
      ),
    );
  }
}

