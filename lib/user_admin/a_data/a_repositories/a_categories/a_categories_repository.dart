import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../a_features/user_admin/models/a_category_model.dart';


class AdminCategoryRepository extends GetxController{
  static AdminCategoryRepository get instance => Get.find();

  /// var
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<AdminCategoryModel>> adminGetAllCategories() async{
    try{
      final snapshot = await _db.collection("Categories").get();

      final list = snapshot.docs.map((document) => AdminCategoryModel.fromSnapshot(document)).toList();

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


  /// store new category
  Future<String> addCategory(AdminCategoryModel  category) async{
    try{
      final currentCategory = await _db.collection('Categories').add(category.toJson());

      return currentCategory.id;
    } catch (e){
      throw'Something went wrong while saving Address information. try again later';
    }
  }
}