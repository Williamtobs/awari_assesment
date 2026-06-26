import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.onPressed,
    this.label = 'Add to cart',
    this.contentSlide,
  });

  final VoidCallback onPressed;
  final String label;
  final Animation<Offset>? contentSlide;

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      label,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
    );
    if (contentSlide != null) {
      content = SlideTransition(position: contentSlide!, child: content);
    }

    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, AppDimensions.spaceXs, 0, 0),
        child: Material(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }
}
