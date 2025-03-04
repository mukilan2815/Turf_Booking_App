import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../a_features/a_personalization/controllers/a_user_ctrl.dart';


class AdminUserProfileTile extends StatelessWidget {
  const AdminUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AdminUserController());
    return Obx(() {
      return ListTile(
        leading: const Icon(Iconsax.user, size: 32, color: KColors.white,),
        title: Text(ctrl.user.value.username, style: Theme.of(context).textTheme.headlineSmall!.apply(color: KColors.white),),
        subtitle: Text(ctrl.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: KColors.white),),
        trailing: IconButton(onPressed: onPressed,
            icon: const Icon(Iconsax.edit, color: KColors.white)),
      );
    });
  }
}