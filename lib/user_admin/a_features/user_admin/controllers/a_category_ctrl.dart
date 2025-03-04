import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../a_data/a_repositories/a_categories/a_categories_repository.dart';
import '../models/a_category_model.dart';
import '../screens/categories/a_add_category.dart';
import '../screens/categories/widgets/single_category.dart';

class AdminCategoryController extends GetxController{
  static AdminCategoryController get instance => Get.find();

  /// var
  final categoryName = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  RxBool refreshData = true.obs;
  final Rx<AdminCategoryModel> selectedCategory = AdminCategoryModel.empty().obs;
  final _adminCategoryRepository = Get.put(AdminCategoryRepository());
  RxList<AdminCategoryModel> adminAllCategories = <AdminCategoryModel>[].obs;
  RxList<AdminCategoryModel> adminFeaturedCategories = <AdminCategoryModel>[].obs;

  @override
  void onInit() {
    adminFetchCategories();
    super.onInit();
  }

  /// - load category data
  Future<List<AdminCategoryModel>> adminFetchCategories() async {
    try{
      // show loader while loading categories
      isLoading.value = true;
      // fetch categories from data source
      final categories = await _adminCategoryRepository.adminGetAllCategories();

      return categories;
    } catch(e){
      KLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    } finally{
      // remove loader
      isLoading.value = false;
    }
  }

  Future addNewCategory() async{
    try{
      // start loading
      KFullScreenLoader.openLoadingDialog("Storing Place", KImages.docerAnimation);

      /// check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!categoryFormKey.currentState!.validate()) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // save address data
      final category = AdminCategoryModel(
          id: '',
          name: categoryName.text.trim(),
          isFeatured: true
      );

      final id = await _adminCategoryRepository.addCategory(category);

      // update selected address status
      category.id = id;

      // remove loader
      KFullScreenLoader.stopLoading();

      // show success messages
      KLoaders.successSnackBar(title: 'Congratulations', message: 'your place has been saved successfully.');

      // refresh address data
      refreshData.toggle();

      // reset fields
      resetFormFields();

      // redirect
      Navigator.of(Get.context!).pop();

    } catch(e){
      // remove loader
      KFullScreenLoader.stopLoading();
      KLoaders.errorSnackBar(title: 'place not found',message: e.toString());
    }
  }

  /// show address modelBottom sheet at checkout
  Future<dynamic> selectNewCategoryPopup(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(KSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KSectionHeading(title: "Select Turf Places",showActionButton: false,),
              const SizedBox(height: KSizes.spaceBtwItems,),
              FutureBuilder(
                  future: adminFetchCategories(),
                  builder: (_,snapshot) {
                    /// helper function handle loader , no record , or error message
                    final response = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_,index) =>  KSingleCategory(
                          category: snapshot.data![index],
                          onTap: () async {
                          selectedCategory(snapshot.data![index]);
                          Get.back();
                          },
                        )
                    );
                  }
              ),
              const SizedBox(height: KSizes.defaultSpace * 2,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to( () => const AddNewCategoryScreen()), child: const Text('Add new Place')),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// reset form fields
  void resetFormFields(){
    categoryName.clear();
    categoryFormKey.currentState?.reset();
  }
}