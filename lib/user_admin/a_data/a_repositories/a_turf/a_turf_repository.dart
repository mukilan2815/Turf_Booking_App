import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../a_features/user_admin/models/a_turf_model.dart';
import '../a_authentication/a_authentication_repository.dart';

class AdminTurfRepository extends GetxController{
  static AdminTurfRepository get instance => Get.find();

  /// firebase interactions
  final _db = FirebaseFirestore.instance;

  /// get limited featured
  Future<List<AdminTurfModel>> adminGetAllFeaturedTurfs() async{
    try{
      final adminUserId = AuthenticationRepositoryAdmin.instance.adminAuthUser!.uid;
      if(adminUserId.isEmpty) throw "Unable to find admin user information. Try again in few minutes";

      final snapshot = await _db.collection('Turfs')
          .where("AdminId",isEqualTo: adminUserId).get();
      return snapshot.docs.map((
          e)=> AdminTurfModel.fromSnapshot(e)).toList();

    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }

  /// store new product
  Future<String> adminSaveTurfs(AdminTurfModel product) async{
    try{
      final currentProduct = await _db.collection('Turfs').add(product.toJson());

      return currentProduct.id;
    } catch(e){
      throw "Something went wrong while Saving Order Information. Try again later";
    }
  }

  /// add product image
  Future<String> uploadTurfImage(String path,XFile image) async{
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'General Error: $e';
    }
  }
}