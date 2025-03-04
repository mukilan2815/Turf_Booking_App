import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../controllers/a_signup_ctrl/a_signup_ctrl.dart';

class AdminSignupScreen extends StatelessWidget {
  const AdminSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminSignupController());

    return Scaffold(
      appBar: KAppBar(
        title: Text("Create Account", style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [

              /// title
              Text(KTexts.adminSignUpTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: KSizes.spaceBtwSections,),

              /// form
              Form(
                key: ctrl.signupFormKey,
                child: Column(
                  children: [

                    /// user name
                    TextFormField(
                      controller: ctrl.username,
                      validator: (value) =>
                          KValidator.validateEmptyText('User Name', value),
                      decoration: const InputDecoration(
                        labelText: KTexts.userName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwInputFields,),

                    /// email
                    TextFormField(
                      controller: ctrl.email,
                      validator: (value) => KValidator.validateEmail(value),
                      decoration: const InputDecoration(
                        labelText: KTexts.email,
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwInputFields,),

                    /// phone number
                    TextFormField(
                      controller: ctrl.phoneNumber,
                      validator: (value) =>
                          KValidator.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                        labelText: KTexts.phoneNo,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwInputFields,),

                    /// password
                    Obx(() =>
                        TextFormField(
                          controller: ctrl.password,
                          validator: (value) => KValidator.validatePassword(value),
                          obscureText: ctrl.hidePassword.value,
                          decoration: InputDecoration(
                            labelText: KTexts.password,
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                                onPressed: () => ctrl.hidePassword.value = !ctrl.hidePassword.value,
                                icon: Icon(ctrl.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: KSizes.spaceBtwInputFields,),

                    /// signup button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => ctrl.adminSignup(),
                        child:  Text(KTexts.createAccount,style: Theme.of(context).textTheme.headlineMedium,),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
