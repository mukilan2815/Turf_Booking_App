import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/login/login_screen/login.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../a_common/a_list_tiles/a_settings_menu_tile.dart';
import '../../../../a_common/a_list_tiles/a_user_profile_tile.dart';
import '../../../user_admin/screens/categories/a_categoires_display.dart';
import '../profile/admin_profile.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --Header
            KPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// appbar
                    KAppBar(title: Text('Account',style: Theme.of(context).textTheme.headlineMedium!.apply(color: KColors.white),),),

                    /// user profile card
                    AdminUserProfileTile(onPressed: () => Get.to(() => const AdminProfileScreen()),),

                    /// space btw container
                    const SizedBox(height: KSizes.spaceBtwSections,),
                  ],
                )
            ),

            /// --Body
            Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Column(
                children: [
                  /// account Settings
                  const KSectionHeading(title: 'Account Settings',showActionButton: false,),
                  const SizedBox(height: KSizes.spaceBtwItems,),

                  AdminSettingsMenuTile(
                    icon: Iconsax.category,
                    title: 'Places',
                    subTitle: 'Show all Turf Places',
                    onTap: () => Get.to(() => const CategoriesDisplayScreen()),
                  ),

                  const AdminSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),

                  AdminSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(activeColor: KColors.primary,value: true, onChanged: (value) {}),
                  ),

                  const SizedBox(height: KSizes.spaceBtwItems,),

                  /// logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => Get.offAll(  const LoginScreen()),
                        child: Text('Logout',style: Theme.of(context).textTheme.headlineMedium)
                    ),
                  ),

                  const SizedBox(height: KSizes.spaceBtwSections * 2.5,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
