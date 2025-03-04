import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../user_client/c_features/c_personalization/screens/settings/client_settings.dart';
import '../../user_client/c_features/user_client/screens/home_screen/client_home_screen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';


class ClientNavigationMenu extends StatelessWidget {
  const ClientNavigationMenu({super.key});


  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(NavigationClientController());
    final dark = KHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: ctrl.selectedIndex.value,
          onDestinationSelected: (index) => ctrl.selectedIndex.value = index,
          backgroundColor: dark ? KColors.black : Colors.white,
          indicatorColor: KColors.primary,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => ctrl.screens[ctrl.selectedIndex.value]),
    );
  }
}

class NavigationClientController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const ClientHomeScreen(),
    const ClientSettingsScreen()
  ];
}

