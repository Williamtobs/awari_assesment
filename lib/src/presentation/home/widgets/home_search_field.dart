import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    super.key,
    this.hintText = 'Search your needs',
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.softFill,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(color: const Color(0xFFE6E3DA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 22, color: AppColors.inkMuted),
          const SizedBox(width: AppDimensions.spaceSm),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.ink,
              style: const TextStyle(fontSize: 15, color: AppColors.ink),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.inkMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
