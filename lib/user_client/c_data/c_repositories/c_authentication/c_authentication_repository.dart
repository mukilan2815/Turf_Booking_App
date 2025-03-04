import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/login/login_screen/login.dart';
import '../../../../common/onboarding/onboarding_screen.dart';
import '../c_user/c_user_repository.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepositoryClient extends GetxController {
  static AuthenticationRepositoryClient get instance => Get.find();

  /// var
  final clientDeviceStorage1 = GetStorage();
  final _clientAuth = FirebaseAuth.instance;

  /// get authenticated user data
  User? get clientAuthUser => _clientAuth.currentUser;

  ///
  @override
  void onReady() {
    /// remove native splash screen
    FlutterNativeSplash.remove();

    /// redirect to screen
    clientScreenRedirect();
  }

  clientScreenRedirect() async {
    // final clientUser = _clientAuth.currentUser;
    // if (clientUser != null) {
    //   await KLocalStorage.init(clientUser.uid);
    // }

    clientDeviceStorage1.writeIfNull('IsFirstClientTime', true);
    //
    clientDeviceStorage1.read('IsFirstClientTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
  }

  /* ------------------------------- Email & Password Sign-in----------------------------------------- */

  /// -- Login
  Future<UserCredential> clientLoginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _clientAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// -- Register
  Future<UserCredential> clientRegisterWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _clientAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// -- ReAuthenticate User

  /* ------------------------------- end identity ----------------------------------------- */

  /// -- [Logout] - valid for any authentication
  Future<void> clientLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// -- Delete User
  Future<void> deleteClientAccount() async {
    try {
      await ClientUserRepository.instance
          .removeClientUserRecord(_clientAuth.currentUser!.uid);
      await _clientAuth.currentUser?.delete();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
