import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../../user_client/c_features/c_authentication/controllers/c_login_ctrl/c_login_ctrl.dart';
import '../../../../../user_client/c_features/c_authentication/screens/c_signup/c_signup_screen.dart';

class ClientLoginTab extends StatelessWidget {
  const ClientLoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientLoginController());

    return Form(
      key: ctrl.clientLoginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// email
          TextFormField(
            controller: ctrl.email,
            validator: (value) => KValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct_right),
              labelText: KTexts.email,
              labelStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields / 8,
          ),

          /// password
          Obx(
            () => TextFormField(
              controller: ctrl.password,
              validator: (value) => KValidator.validatePassword(value),
              obscureText: ctrl.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: KTexts.password,
                labelStyle: Theme.of(context).textTheme.headlineMedium,
                suffixIcon: IconButton(
                    onPressed: () =>
                        ctrl.hidePassword.value = !ctrl.hidePassword.value,
                    icon: Icon(ctrl.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields / 8,
          ),

          ///remember me
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: ctrl.rememberMeC.value,
                        onChanged: (value) =>
                            ctrl.rememberMeC.value = !ctrl.rememberMeC.value),
                  ),
                  Text(
                    KTexts.rememberMe,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          ),

          /// sign in button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ctrl.clientEmailAndPasswordSignIn(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Replace green with blue
                foregroundColor: Colors.white, // Text/icon color
              ),
              child: const Text(
                KTexts.signIn,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields / 8,
          ),

          /// create account button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const ClientSignupScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Replace green with blue
                foregroundColor: Colors.white, // Text/icon color
              ),
              child: const Text(
                KTexts.createAccount,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}