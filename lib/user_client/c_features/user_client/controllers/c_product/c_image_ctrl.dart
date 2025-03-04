import 'package:get/get.dart';

import '../../models/c_product_model.dart';

class ClientImageController extends GetxController{
  static ClientImageController get instance => Get.find();

  // var
  RxString selectedProductImage = "".obs;

  List<String> getAllProductImages(ClientProductModel product) {

    Set<String> images ={};
    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;
    return images.toList();
  }

}