import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'card_user/admin_login_tab.dart';
import 'card_user/client_login_tab.dart';


class KLoginForm extends StatefulWidget {
  const KLoginForm({super.key});

  @override
  State<KLoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<KLoginForm>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final dark = KHelperFunctions.isDarkMode(context);

    return Card(
      color: dark ? KColors.dark : KColors.white ,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: dark ? KColors.white : KColors.dark ,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: KColors.primary ,
              ),
              labelColor: dark ? KColors.dark : KColors.light ,
              labelStyle: Theme.of(context).textTheme.headlineSmall,
              unselectedLabelColor: dark ? KColors.light : KColors.dark,
              dividerHeight: 0,
              tabs: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                    child: Tab(text: 'Client Login',)
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                  child: Tab(text: 'Admin Login'),
                ),
              ],
            ),
            const SizedBox(height: KSizes.sm,),
            SizedBox(
              height: KDeviceUtils.getScreenHeight() /2.8,
              width: KDeviceUtils.getScreenWidth(context) / 1,
              child: TabBarView(
                controller: _tabController,
                children: const [ClientLoginTab(), AdminLoginTab(),],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
