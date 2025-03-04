import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../c_features/c_personalization/models/c_user_model.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../c_authentication/c_authentication_repository.dart';


class ClientUserRepository extends GetxController{
  static ClientUserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// save user data to firebase
  Future<void> saveClientUserRecord(ClientUserModel user) async {
    try{
      await _db.collection("ClientUsers").doc(user.id).set(user.toJson());
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
  Future<ClientUserModel> fetchClientUserRecord() async {
    try{
     final documentSnapshot = await _db.collection("ClientUsers").doc(AuthenticationRepositoryClient.instance.clientAuthUser?.uid).get();
     if (documentSnapshot.exists) {
       return ClientUserModel.fromSnapshot(documentSnapshot);
     }  else{
       return ClientUserModel.empty();
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
  Future<void> updateClientUserRecord(ClientUserModel updatedUser) async {
    try{
      await _db.collection("ClientUsers").doc(updatedUser.id).update(updatedUser.toJson());
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
  Future<void> updateClientUserField(Map<String , dynamic> json) async {
    try{
      await _db.collection("ClientUsers").doc(AuthenticationRepositoryClient.instance.clientAuthUser?.uid).update(json);
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
  Future<void> removeClientUserRecord(String userId) async {
    try{
      await _db.collection("ClientUsers").doc(userId).delete();
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

  ///  upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

}
