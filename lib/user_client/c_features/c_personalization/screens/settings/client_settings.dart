import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/login/login_screen/login.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../c_common/c_list_tiles/c_settings_menu_tile.dart';
import '../../../../c_common/c_list_tiles/c_user_profile_tile.dart';
import '../../../user_client/screens/order/order_screen.dart';
import '../profile/client_profile.dart';

class ClientSettingsScreen extends StatelessWidget {
  const ClientSettingsScreen({super.key});

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
                    ClientUserProfileTile(onPressed: () => Get.to( const ClientProfileScreen()),),

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

                  ClientSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Booking',
                    subTitle: 'In_progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),

                  const ClientSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
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
