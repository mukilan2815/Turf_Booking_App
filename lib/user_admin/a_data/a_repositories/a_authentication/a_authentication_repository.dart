import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/login/login_screen/login.dart';
import '../../../../common/onboarding/onboarding_screen.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../a_user/a_user_repository.dart';


class AuthenticationRepositoryAdmin extends GetxController{
  static AuthenticationRepositoryAdmin get instance => Get.find();

  /// var
  final adminDeviceStorage = GetStorage();
  final _adminAuth = FirebaseAuth.instance;

  /// get authenticated user data
  User? get adminAuthUser => _adminAuth.currentUser;

  ///
  @override
  void onReady(){
    /// remove native splash screen
    FlutterNativeSplash.remove();
    /// redirect to screen
    adminScreenRedirect();
  }

  adminScreenRedirect() async{
    adminDeviceStorage.writeIfNull('IsFirstAdminTime', true);

      adminDeviceStorage.read('IsFirstAdminTime') != true
          ? Get.offAll(()=> const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
  }

  /* ------------------------------- Email & Password Sign-in----------------------------------------- */

  /// -- Login
  Future<UserCredential> adminLoginWithEmailAndPassword(String email, String password) async{
    try{
      return await _adminAuth.signInWithEmailAndPassword(email: email, password: password);
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

  /// -- Register
  Future<UserCredential> adminRegisterWithEmailAndPassword(String email, String password) async{
    try{
      return await _adminAuth.createUserWithEmailAndPassword(email: email, password: password);
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

  /// -- ReAuthenticate User

/* ------------------------------- end identity ----------------------------------------- */
  /// -- [Logout] - valid for any authentication
  Future <void> adminLogout() async{
    try{
      await FirebaseAuth.instance.signOut();
      Get.offAll(()=>const LoginScreen());
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
  /// -- Delete User
  Future<void> deleteAdminAccount() async{
    try{
      await AdminUserRepository.instance.removeAdminUserRecord(_adminAuth.currentUser!.uid);
      await _adminAuth.currentUser?.delete();
      Get.offAll(()=>const LoginScreen());
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
