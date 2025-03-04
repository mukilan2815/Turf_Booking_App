import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../c_features/c_personalization/controllers/c_user_ctrl.dart';

class ClientUserProfileTile extends StatelessWidget {
  const ClientUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ClientUserController());
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