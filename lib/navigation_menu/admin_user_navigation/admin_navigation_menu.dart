import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../user_admin/a_features/a_personalization/screens/settings/admin_settings.dart';
import '../../user_admin/a_features/user_admin/screens/Home_screen/admin_home_screen.dart';
import '../../user_admin/a_features/user_admin/screens/add_turf/add_turf_screen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';


class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(NavigationAdminController());
    final dark = KHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx (
            () => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: ctrl.selectedIndex.value,
              onDestinationSelected: (index) => ctrl.selectedIndex.value = index,
              backgroundColor: dark ? KColors.black: Colors.white,
              indicatorColor: KColors.primary,

              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(icon: Icon(Iconsax.add), label: 'Add Item'),
                NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
              ],
            ),
      ),
      body: Obx(() => ctrl.screens[ctrl.selectedIndex.value]),
    );
  }
}

class NavigationAdminController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const AdminHomeScreen(),
    const AddTurfScreen(),
    const AdminSettingsScreen()
  ];
}
