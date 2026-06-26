import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/soft_icon_button.dart';

class DetailTopBar extends StatelessWidget {
  const DetailTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.onBagTap,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onBagTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SoftIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBack ?? () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              letterSpacing: 0.2,
            ),
          ),
        ),
        SoftIconButton(
          icon: Icons.shopping_bag_outlined,
          onTap: onBagTap,
        ),
      ],
    );
  }
}
