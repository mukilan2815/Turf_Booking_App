import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../navigation_menu/client_user_navigation/client_navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../c_data/c_repositories/c_authentication/c_authentication_repository.dart';


class ClientLoginController extends GetxController{

  /// Variables
  final rememberMeC =false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> clientLoginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    loadCredentials();
    super.onInit();
  }

  /// remember me loader
  void loadCredentials() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL_C') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD_C') ?? '';
  }

  /// - email and password sign
  Future<void>clientEmailAndPasswordSignIn() async{

    try{
      // start loading
      KFullScreenLoader.openLoadingDialog('Logging you in', KImages.docerAnimation);

      // check internet connect
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        KFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!clientLoginFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is selected
      if (rememberMeC.value) {
        localStorage.write('REMEMBER_ME_EMAIL_C', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD_C', password.text.trim());
      }

      // login user using Email & password authentication
      final userCredentials = await AuthenticationRepositoryClient.instance.clientLoginWithEmailAndPassword(email.text.trim(), password.text.trim());

      await KLocalStorage.init(userCredentials.user!.uid);
      // remove loader
      KFullScreenLoader.stopLoading();

      // redirect
      //AuthenticationRepositoryClient.instance.clientScreenRedirect();
      Get.offAll(()=> const ClientNavigationMenu());
    } catch(e){
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: "On Snap" ,message: e.toString());
    }

  }
}