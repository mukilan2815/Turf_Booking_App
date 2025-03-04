import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../a_data/a_repositories/a_authentication/a_authentication_repository.dart';
import '../../../a_data/a_repositories/a_turf/a_turf_repository.dart';
import '../models/a_turf_model.dart';
import 'a_category_ctrl.dart';

class AdminTurfController extends GetxController{
  static AdminTurfController get instance => Get.find();

  final title = TextEditingController();
  final price = TextEditingController();
  final address = TextEditingController();
  final players = TextEditingController();
  var thumbnail = Rxn<File>();
  XFile? image;
  String? thumbnailUrl;
  GlobalKey<FormState> turfFormKey = GlobalKey<FormState>();
  final adminCategoryCtrl = AdminCategoryController.instance;

  final adminTurfRepository = (Get.put(AdminTurfRepository()));
  RxList<AdminTurfModel> adminFeaturedTurfs =<AdminTurfModel>[].obs;

  /// fetch all products admin user
  Future<List<AdminTurfModel>> adminAllFetchFeaturedTurfs() async {
    try{
      // all fetch products
      final turfs = await adminTurfRepository.adminGetAllFeaturedTurfs();
      return turfs;
    } catch(e) {
      KLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  /// image picker
  Future<void> uploadTurfImage(ImageSource source) async{
    try{
      final  imageT = await ImagePicker().pickImage(source: source);
      if (imageT != null) {
        image = imageT;
        thumbnail.value = File(imageT.path);
      }
    } catch(e){
      KLoaders.errorSnackBar(title: 'Oh Snap!',message: 'Something went wrong: $e');
    }
  }

  /// add methods for order processing
  void addTurf() async{
    try{
      // start loader
      KFullScreenLoader.openLoadingDialog('Adding the Turf', KImages.pencilAnimation);

      // get user authentication id
      final adminId = AuthenticationRepositoryAdmin.instance.adminAuthUser!.uid;
      if (adminId.isEmpty) return;

      /// check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!turfFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }
      final imageUrl = await adminTurfRepository.uploadTurfImage('Turf/image', image!);
      thumbnailUrl = imageUrl;

      final priceValue = double.tryParse(price.text.trim()) ?? 0.0;
      final playersValue = int.tryParse(players.text.trim()) ?? 0;

      // add details
      final turf = AdminTurfModel(
          id: '',
          title: title.text.trim(),
          address: address.text.trim(),
          price: priceValue,
          thumbnail: thumbnailUrl as String,
          adminId: adminId,
          categoryId: adminCategoryCtrl.selectedCategory.value.id,
          isFeatured: true,
          players: playersValue,
      );

      // save the order to firestore
      final id = await adminTurfRepository.adminSaveTurfs(turf);

      // update selected address status
      turf.id = id;

      KFullScreenLoader.stopLoading();


      resetFormFields();
      KLoaders.successSnackBar(title: 'Congratulations', message: 'your Place has been saved successfully.');
      // reset fields


      // show success screen
      Get.back();
    } catch(e){
      KLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }

  /// reset form fields
  void resetFormFields(){
    title.clear();
    price.clear();
    address.clear();
    thumbnail.value = null;
    turfFormKey.currentState?.reset();
  }

}