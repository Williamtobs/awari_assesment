import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RoundedNetworkImage extends StatelessWidget {
  const RoundedNetworkImage({
    super.key,
    required this.url,
    required this.background,
    this.radius = 18,
    this.borderRadius,
    this.iconSize = 40,
    this.fit = BoxFit.cover,
  });

  final String? url;
  final Color background;
  final double radius;
  final BorderRadius? borderRadius;
  final double iconSize;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: Container(
        color: background,
        child: url == null
            ? _placeholder()
            : Image.network(
                url!,
                fit: fit,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return _placeholder(loading: true);
                },
                errorBuilder: (context, error, stackTrace) => _placeholder(),
              ),
      ),
    );
  }

  Widget _placeholder({bool loading = false}) {
    return Center(
      child: loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.inkMuted,
              ),
            )
          : Icon(
              Icons.checkroom_rounded,
              size: iconSize,
              color: AppColors.ink.withValues(alpha: 0.25),
            ),
    );
  }
}
