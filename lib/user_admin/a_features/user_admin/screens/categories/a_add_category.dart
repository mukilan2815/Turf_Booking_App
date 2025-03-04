import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../controllers/a_category_ctrl.dart';

class AddNewCategoryScreen extends StatelessWidget {
  const AddNewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = AdminCategoryController.instance;
    return Scaffold(
      appBar: KAppBar(
        showBackArrow: true,
        title: Text('Add New places', style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Form(
          key: ctrl.categoryFormKey,
            child: Column(
              children: [
                /// name
                TextFormField(
                  controller: ctrl.categoryName,
                  validator: (value) => KValidator.validateEmptyText("Places Name", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.category_25), labelText: "Places Name"),
                ),
                const SizedBox(height: KSizes.defaultSpace,),

                /// save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => ctrl.addNewCategory(), child: const Text("Save Places")),
                ),
              ],
            )
        ),
      ),
    );
  }
}
