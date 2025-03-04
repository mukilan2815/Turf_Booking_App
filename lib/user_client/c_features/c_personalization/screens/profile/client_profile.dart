import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../controllers/c_user_ctrl.dart';
import 'widgets/profile_menu.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = ClientUserController.instance;
    return Scaffold(
      appBar: KAppBar(
        showBackArrow: true,
        title: Text('Profile',style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile

              ///Details
              const Divider(),
              const SizedBox(height: KSizes.spaceBtwItems,),
              const KSectionHeading(title: 'Profile Information',showActionButton: false,),
              const SizedBox(height: KSizes.spaceBtwItems),

              /// profile info
              KProfileMenu(title: 'Name', value:ctrl.user.value.username),
              KProfileMenu(title: 'E-mail', value: ctrl.user.value.email),

              const SizedBox(height: KSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: KSizes.spaceBtwItems,),

              /// Personal Info
              const KSectionHeading(title: 'Profile Information',showActionButton: false,),
              const SizedBox(height: KSizes.spaceBtwItems,),

              KProfileMenu(title: 'User ID', value: ctrl.user.value.id),
              KProfileMenu(title: 'Phone Number', value: ctrl.user.value.phoneNumber),
              const Divider(),
              const SizedBox(height: KSizes.spaceBtwItems,),

              /// button
              Center(
                child: TextButton(
                    onPressed: (){},
                    child:  Text('Close Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
