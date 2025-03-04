import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/c_product/c_image_ctrl.dart';
import '../../../models/c_product_model.dart';

class KProductImage extends StatelessWidget {
  const KProductImage({super.key, required this.product,});

  final ClientProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);

    final ctrl = Get.put(ClientImageController());
    final images = ctrl.getAllProductImages(product);
    return KCurvedEdgeWidget(
      child: Container(
        color: dark ? KColors.white: KColors.black,
        child: Stack(
          children: [
            /// Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(KSizes.productImageRadius * 3),
                child: Center(
                    child: Obx((){
                      final image = ctrl.selectedProductImage.value;
                       return CachedNetworkImage(
                         imageUrl: image,
                         placeholder: (context, url) => CircularProgressIndicator(color:KColors.primary),
                         errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                       );
                      //return Image(image: AssetImage(product.thumbnail),fit: BoxFit.contain,);
                      })
                ),
              ),
            ),

            /// appbar icons
            KAppBar(showBackArrow: true,),

          ],
        ),
      ),
    );
  }
}