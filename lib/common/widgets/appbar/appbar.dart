
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget{
  const KAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton( onPressed: () => Get.back(),icon: const Icon(Icons.arrow_back_ios, color: KColors.primary),)
            : leadingIcon != null
            ? IconButton( onPressed: leadingOnPressed,icon: Icon(leadingIcon))
            : null,
        title: title,
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  /// TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
}
