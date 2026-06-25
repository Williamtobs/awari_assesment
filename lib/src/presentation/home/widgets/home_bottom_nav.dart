import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.contentSlide,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  final Animation<Offset>? contentSlide;

  static const _items = <IconData>[
    Icons.home_outlined,
    Icons.favorite_border_rounded,
    Icons.settings_outlined,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, AppDimensions.spaceXs, 0, 0),
        padding: const EdgeInsets.symmetric(vertical: 6),
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: _maybeSlide(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _items.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 0 : AppDimensions.spaceXl,
                  ),
                  child: _NavItem(
                    icon: _items[i],
                    isActive: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _maybeSlide(Widget child) {
    if (contentSlide == null) return child;
    return SlideTransition(position: contentSlide!, child: child);
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          size: 26,
          color: isActive ? AppColors.ink : AppColors.inkMuted,
        ),
      ),
    );
  }
}
