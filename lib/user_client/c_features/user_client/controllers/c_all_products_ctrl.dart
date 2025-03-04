import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../c_data/c_repositories/c_product/c_product_repository.dart';
import '../models/c_product_model.dart';

class ClientAllProductsController extends GetxController{
  static ClientAllProductsController get instance => Get.find();

  final repository = ClientProductRepository.instance;
  final RxString selectedSortOption ='Name'.obs;
  final RxList<ClientProductModel> products = <ClientProductModel>[].obs;

  Future<List<ClientProductModel>> clientFetchProductsByQuery(Query? query) async{
    try{
      if(query == null) return [];

      final products = await repository.clientFetchProductsByQuery(query);

      return products;
    } catch(e){
      KLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  void clientSortProducts (String sortOption){
    selectedSortOption.value = sortOption;

    switch(sortOption){
      case 'Name' :
        products.sort((a,b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price' :
        products.sort((a,b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price' :
        products.sort((a,b) => a.price.compareTo(b.price));
        break;
      default:
        products.sort((a,b) => a.title.compareTo(b.title));
    }
  }

  void clientAssignProducts(List<ClientProductModel> products){
    this.products.assignAll(products);
    clientSortProducts('Name');
  }
}