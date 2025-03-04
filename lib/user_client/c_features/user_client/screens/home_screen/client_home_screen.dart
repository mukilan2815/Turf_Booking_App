import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../c_common/c_categories_bar/categories_body.dart';
import '../../../../c_common/c_products/c_product_cards/c_product_card_vertical.dart';
import '../../controllers/c_product/c_product_ctrl.dart';
import '../all_products_screen/all_products.dart';


class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientProductController());
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            KPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// app bar
                  KAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(KTexts.homeAppbarTitle,style: Theme.of(context).textTheme.labelMedium!.apply(color: KColors.grey),),
                        Text(KTexts.homeAppbarSubTitle,style: Theme.of(context).textTheme.headlineSmall!.apply(color: KColors.white),),
                      ],
                    ),
                  ),
                  //const SizedBox(height: KSizes.spaceBtwItems,),

                  /// search Bar
                  // KSearchContainer(
                  //   text: 'Search in Store', icon: Iconsax.search_normal,
                  //   onTap: (){},
                  // ),
                  // const SizedBox(height: KSizes.defaultSpace,),

                  /// categories
                  const Padding(
                    padding: EdgeInsets.only(left: KSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// categories heading
                        KSectionHeading(title: 'Popular Turf Places',showActionButton: false,textColor: KColors.white,),
                        //const SizedBox(height: KSizes.spaceBetween,),
                        /// categories
                        KCategoriesBody(),
                      ],
                    ),
                  ),
                  const SizedBox(height: KSizes.spaceBtwSections,),
                ],
              )
            ),

            /// body
            Padding(
              padding: const EdgeInsets.all(KSizes.spaceBtwItems),
              child: Column(
                children: [
                  KSectionHeading(
                    title: "Popular Turfs",
                    onPressed: () => Get.to(()=> AllProducts(
                      title: 'Popular Turfs',
                      futureMethod: ctrl.clientAllFetchFeaturedProducts(),
                    )),

                  ),
                  const SizedBox(height: KSizes.spaceBtwItems,),

                  Obx((){
                    if (ctrl.isLoading.value) return KVerticalProductShimmer();

                    if (ctrl.clientFeaturedProducts.isEmpty) {
                      return Center(child: Text('No Data Found!',style: Theme.of(context).textTheme.bodyMedium,),);
                    }  
                    return KGridLayout(
                      itemCount: ctrl.clientFeaturedProducts.length,
                      itemBuilder: (_,index) =>  KProductCardVertical(
                        product: ctrl.clientFeaturedProducts[index],),
                    );
                  }),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}














