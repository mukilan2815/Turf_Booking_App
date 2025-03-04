import 'package:get/get.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../c_data/c_repositories/c_product/c_product_repository.dart';
import '../../models/c_product_model.dart';


class ClientProductController extends GetxController {
  static ClientProductController get instance => Get.find();

  final isLoading = false.obs;
  final clientProductRepository = (Get.put(ClientProductRepository()));
  RxList<ClientProductModel> clientFeaturedProducts =<ClientProductModel>[].obs;

  @override
  void onInit() {
    clientFetchFeaturedProducts();
    super.onInit();
  }

  void clientFetchFeaturedProducts() async {
    try{
      // show loader
      isLoading.value = true;

      // fetch products
      final products = await clientProductRepository.clientGetFeaturedProducts();

      //assign products
      clientFeaturedProducts.assignAll(products);
    } catch(e) {
      KLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
    }finally {
      isLoading.value = false;
    }
  }

  Future<List<ClientProductModel>> clientAllFetchFeaturedProducts() async {
    try{
      // all fetch products
      final products = await clientProductRepository.clientGetAllFeaturedProducts();
      return products;
    } catch(e) {
      KLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  /// price
  String getClientProductPrice(ClientProductModel product){
    return (product.price).toString();
  }

  /// stock
  String getClientStockStatus(int stock){
    return stock > 0 ? "In Stock" : "Out of Stock";
  }

}