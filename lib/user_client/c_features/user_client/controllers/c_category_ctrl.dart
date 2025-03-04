
import 'package:get/get.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../c_data/c_repositories/c_categories/c_categories_repository.dart';
import '../../../c_data/c_repositories/c_product/c_product_repository.dart';
import '../models/c_category_model.dart';
import '../models/c_product_model.dart';



class ClientCategoryController extends GetxController{
  static ClientCategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _clientCategoryRepository = Get.put(ClientCategoryRepository());
  final _clientProductRepository = Get.put(ClientProductRepository());
  RxList<ClientCategoryModel> clientAllCategories = <ClientCategoryModel>[].obs;
  RxList<ClientCategoryModel> clientFeaturedCategories = <ClientCategoryModel>[].obs;

  @override
  void onInit() {
    clientFetchCategories();
    super.onInit();
  }

  /// - load category data
  Future<void> clientFetchCategories() async {
    try{
      // show loader while loading categories
      isLoading.value = true;

      // fetch categories from data source
      final categories = await _clientCategoryRepository.clientGetAllCategories();
      print('Fetched categories: ${categories.length}');

      // update the categories list
      clientAllCategories.assignAll(categories);

      // filter featured categories
      clientFeaturedCategories.assignAll(clientAllCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

    } catch(e){
      KLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    } finally{
      // remove loader
      isLoading.value = false;
    }
  }

  /// load selected category data
  Future<List<ClientProductModel>> clientGetCategoriesProducts(String categoryId) async{
    try{
      final products = await _clientProductRepository.clientGetProductsForCategories(categoryId);
      return products;
    } catch (e) {
      KLoaders.errorSnackBar(title: "Oh Snap!",message: e.toString());
      return [];
    }
  }


  /// Get category products
}