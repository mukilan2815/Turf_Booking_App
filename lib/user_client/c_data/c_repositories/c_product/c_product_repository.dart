import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../c_features/user_client/models/c_product_model.dart';

class ClientProductRepository extends GetxController{
  static ClientProductRepository get instance => Get.find();

  /// firebase interactions
  final _db = FirebaseFirestore.instance;

  /// get limited featured
  Future<List<ClientProductModel>> clientGetFeaturedProducts() async{
    try{
      final snapshot = await _db.collection('Turfs')
          .where("IsFeatured",isEqualTo: true).limit(4).get();
      return snapshot.docs.map((
          e)=> ClientProductModel.fromSnapshot(e)).toList();

    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }

  /// get limited featured
  Future<List<ClientProductModel>> clientGetAllFeaturedProducts() async{
    try{
      final snapshot = await _db.collection('Turfs')
          .where("IsFeatured",isEqualTo: true).get();
      return snapshot.docs.map((
          e)=> ClientProductModel.fromSnapshot(e)).toList();

    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }

  Future<List<ClientProductModel>> clientFetchProductsByQuery(Query query) async{
    try{
      final querySnapshot = await query.get();
      final List<ClientProductModel> productList = querySnapshot.docs.map((
          doc) => ClientProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }

  Future<List<ClientProductModel>> clientGetFavouriteProducts(List<String> productIds) async{
    try{
      final snapshot = await _db.collection('Turfs')
          .where(FieldPath.documentId,whereIn: productIds).get();

      return snapshot.docs.map((querySnapshot) =>
          ClientProductModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }

  /// get product for categories
  Future<List<ClientProductModel>> clientGetProductsForCategories(String categoryId) async{
    try{
      final snapshot = await _db.collection("Turfs")
          .where("CategoryId",isEqualTo: categoryId).get();

      return snapshot.docs.map((
          docs) => ClientProductModel.fromSnapshot(docs)).toList();
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
      //throw 'Something went wrong. Please try again';
    }
  }


  /// upload
/*  Future<void> uploadDummyData(List<ClientProductModel> products) async{
    try{
      final storage = Get.put(KFirebaseStorageService());

      /// loop through each product
      for(var product in products){
        //get image link
        final thumbnail = await storage.getImageDataFormAssets(product.thumbnail);
      }

      await _db.collection('Products').doc().set(product.tojson());
    } on FirebaseException catch(e){
      throw e.message!;
    } on PlatformException catch(e) {
      throw e.message!;
    } catch(e){
      throw e.toString();
  }
  }*/

}