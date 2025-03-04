import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../a_common/turf/a_turf_card.dart';
import '../../controllers/a_turf_ctrl.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminTurfController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --Header
            KPrimaryHeaderContainer(
              child: Column(
                children: [
                  KAppBar(title: Text('Your Turfs',
                    style: Theme.of(context).textTheme.headlineLarge!.apply(color:KColors.white ),),
                  ),
                  const SizedBox(height: KSizes.spaceBtwSections,),
                ],
              ),
            ),


            /// body
            Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: FutureBuilder(
                future: ctrl.adminAllFetchFeaturedTurfs(),
                builder: (context, snapshot) {
                  // check the state of future builder
                  const loader = KVerticalProductShimmer();
                  final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                  // return appropriate widget based on snapshot state
                  if (widget != null) return widget;
                  // Products found
                  final products = snapshot.data!;

                  return KGridLayout(
                      mainAxisEvent: 245,
                      itemCount: products.length,
                      itemBuilder: (_, index) => AdminTurfCard(product: products[index],)
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
