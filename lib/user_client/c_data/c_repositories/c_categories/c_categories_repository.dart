import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../c_features/user_client/models/c_category_model.dart';




class ClientCategoryRepository extends GetxController{
  static ClientCategoryRepository get instance => Get.find();

  /// var
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<ClientCategoryModel>> clientGetAllCategories() async{
    try{
      final snapshot = await _db.collection("Categories").get();

      final list = snapshot.docs.map((document) => ClientCategoryModel.fromSnapshot(document)).toList();

      return list;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
      //throw 'Something went wrong. Please try again';
    }
  }

  /// upload categories to the cloud Firebase


}
