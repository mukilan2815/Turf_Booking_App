
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/login/login_screen/login.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../a_data/a_repositories/a_authentication/a_authentication_repository.dart';
import '../../../a_data/a_repositories/a_user/a_user_repository.dart';
import '../models/a_user_model.dart';



class AdminUserController extends GetxController{
  static AdminUserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<AdminUserModel> user = AdminUserModel.empty().obs;
  final adminUserRepository = Get.put(AdminUserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchAdminRecord();
  }

  /// fetch user record
  Future<void>fetchAdminRecord()async {
    try{
      profileLoading.value = true;
      final fetchedUser = await adminUserRepository.fetchAdminUserRecord();
      user(fetchedUser);
    } catch(e){
      user(AdminUserModel.empty());
    } finally{
      profileLoading.value = false;
    }
  }

  /// save user record from any registration provider
  Future<void> saveAdminUserRecord(UserCredential? userCredentials)async{
    try{
      if (userCredentials !=null) {
        final username = AdminUserModel.generateUserName(userCredentials.user!.displayName ?? '');

        // Map data
        final user = AdminUserModel(
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? "",
            phoneNumber: userCredentials.user!.phoneNumber ?? "",
        );

        await adminUserRepository.saveAdminUserRecord(user);
      }  
    } catch (e){
      KLoaders.warningSnackBar(
          title: 'Data not saved',
          message: 'Something went wrong while saving your information.You can re-save your data in your Profile',
      );
    }
  }

  /// delete account warning
  void deleteAccountWaringPopup(){
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(KSizes.md),
      title: "Delete Account",
      middleText: "Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently",
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: KSizes.lg),child: Text('Delete'),),
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: Text('Cancel'),
      ),
    );
  }

  /// delete user account
  Future<void> deleteUserAccount() async {
    try{
      KFullScreenLoader.openLoadingDialog('Processing', KImages.docerAnimation);

      final auth = AuthenticationRepositoryAdmin.instance;
      final provider = auth.adminAuthUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        await auth.deleteAdminAccount();
        KFullScreenLoader.stopLoading();
        Get.offAll(const LoginScreen());
      }  
    }catch (e){
      KFullScreenLoader.stopLoading();
      KLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }

}