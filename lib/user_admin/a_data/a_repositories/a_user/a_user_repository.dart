import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../a_features/a_personalization/models/a_user_model.dart';
import '../a_authentication/a_authentication_repository.dart';


class AdminUserRepository extends GetxController{
  static AdminUserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// save user data to firebase
  Future<void> saveAdminUserRecord(AdminUserModel user) async {
    try{
      await _db.collection("AdminUsers").doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// fetch the user id
  Future<AdminUserModel> fetchAdminUserRecord() async {
    try{
      final documentSnapshot = await _db.collection("AdminUsers").doc(AuthenticationRepositoryAdmin.instance.adminAuthUser?.uid).get();
      if (documentSnapshot.exists) {
        return AdminUserModel.fromSnapshot(documentSnapshot);
      }  else{
        return AdminUserModel.empty();
      }
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// update user data in Firestore
  Future<void> updateAdminUserRecord(AdminUserModel updatedUser) async {
    try{
      await _db.collection("AdminUsers").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// update any field in single users collection
  Future<void> updateAdminUserField(Map<String , dynamic> json) async {
    try{
      await _db.collection("AdminUsers").doc(AuthenticationRepositoryAdmin.instance.adminAuthUser?.uid).update(json);
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// remove user data
  Future<void> removeAdminUserRecord(String userId) async {
    try{
      await _db.collection("AdminUsers").doc(userId).delete();
    } on FirebaseAuthException catch(e){
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }

/// update image
}