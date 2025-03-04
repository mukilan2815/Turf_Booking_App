import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../navigation_menu/admin_user_navigation/admin_navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../a_data/a_repositories/a_authentication/a_authentication_repository.dart';


class AdminLoginController extends GetxController{

  /// Variables
  final rememberMeA =false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> adminLoginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    loadCredentials();
    super.onInit();
  }

  /// remember me loader
  void loadCredentials() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL_A') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD_A') ?? '';
  }

  Future<void>adminEmailAndPasswordSignIn() async{

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
      if (!adminLoginFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is selected
      if (rememberMeA.value) {
        localStorage.write('REMEMBER_ME_EMAIL_A', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD_A', password.text.trim());
      }

      // login user using Email & password authentication
      final userCredentials = await AuthenticationRepositoryAdmin.instance.adminLoginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      KFullScreenLoader.stopLoading();

      // redirect
      //AuthenticationRepositoryAdmin.instance.adminScreenRedirect();
      Get.offAll(()=> const AdminNavigationMenu());
    } catch(e){
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: "On Snap" ,message: e.toString());
    }

  }

}