import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    this.onMenuTap,
    this.onBagTap,
  });

  final VoidCallback? onMenuTap;
  final VoidCallback? onBagTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SoftIconButton(icon: Icons.menu_rounded, onTap: onMenuTap),
        Expanded(
          child: Text(
            'Lumière',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              letterSpacing: 0.2,
            ),
          ),
        ),
        _SoftIconButton(
          icon: Icons.shopping_bag_outlined,
          onTap: onBagTap,
        ),
      ],
    );
  }
}

class _SoftIconButton extends StatelessWidget {
  const _SoftIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double size = 44;
    return Material(
      color: AppColors.softFill,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: 22, color: AppColors.ink),
        ),
      ),
    );
  }
}
