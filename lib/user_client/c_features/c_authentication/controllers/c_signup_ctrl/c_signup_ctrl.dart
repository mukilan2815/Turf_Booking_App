import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../c_data/c_repositories/c_authentication/c_authentication_repository.dart';
import '../../../../c_data/c_repositories/c_user/c_user_repository.dart';
import '../../../c_personalization/models/c_user_model.dart';



class ClientSignupController extends GetxController {
  static ClientSignupController get instance => Get.find();

  /// --variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- signup
  void clientSignup() async {

    try{
      /// start loading
      KFullScreenLoader.openLoadingDialog('We are processing your information....', KImages.docerAnimation);

      /// check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      /// form validation
      if (!signupFormKey.currentState!.validate()) return;

      /// register user
     final userCredential = await AuthenticationRepositoryClient.instance.clientRegisterWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// save authenticated user data
      final newUser  = ClientUserModel(
        id: userCredential.user!.uid,
        username : username.text.trim(),
        email : email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
      );

      final userRepository = Get.put(ClientUserRepository());
      await userRepository.saveClientUserRecord(newUser);

      /// show success message
      KLoaders.successSnackBar(title: 'Congratulations',message: 'Your account has been created Account in Client User!...');


    } catch (e){
      /// error to the user
      KLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());

    }finally{
      ///remove loader
      KFullScreenLoader.stopLoading();
    }

  }

}

