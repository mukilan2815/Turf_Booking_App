import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';

/// A customized choice chip that can act like a radio button.
class KChoiceChip extends StatelessWidget {

  const KChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Use a transparent canvas color to match the existing styling.
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        // Use this function to get Colors as a Chip
        avatar: KHelperFunctions.getColor(text) != null
            ? KCircularContainer(width: 50, height: 50, backgroundColor: KHelperFunctions.getColor(text)!)
            : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: KHelperFunctions.getColor(text),
        labelStyle: TextStyle(color: selected ? KColors.white : null),
        shape: KHelperFunctions.getColor(text) != null ? const CircleBorder() : null,
        label: KHelperFunctions.getColor(text) == null ? Text(text) : const SizedBox(),
        padding: KHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
        labelPadding: KHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}
