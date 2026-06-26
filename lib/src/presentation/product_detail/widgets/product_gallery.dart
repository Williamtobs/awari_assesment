import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/widgets/rounded_network_image.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({
    super.key,
    required this.images,
    required this.swatch,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> images;
  final Color swatch;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final safeIndex = images.isEmpty
        ? 0
        : selectedIndex.clamp(0, images.length - 1);
    final mainImage = images.isEmpty ? null : images[safeIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.spaceMd,
        AppDimensions.spaceMd,
        AppDimensions.spaceMd,
        AppDimensions.spaceMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _MainImage(image: mainImage, swatch: swatch),
          ),
          if (images.length > 1) ...[
            const SizedBox(width: AppDimensions.spaceSm),
            _ThumbnailStrip(
              images: images,
              swatch: swatch,
              selectedIndex: safeIndex,
              onSelected: onSelected,
            ),
          ],
        ],
      ),
    );
  }
}

class _MainImage extends StatelessWidget {
  const _MainImage({required this.image, required this.swatch});

  final String? image;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0.06, 0),
          end: Offset.zero,
        ).animate(animation);
        final scale = Tween<double>(begin: 1.04, end: 1).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slide,
            child: ScaleTransition(scale: scale, child: child),
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [...previousChildren, ?currentChild],
        );
      },
      child: RoundedNetworkImage(
        key: ValueKey<String?>(image),
        url: image,
        background: swatch,
        fit: BoxFit.contain,
        radius: AppDimensions.radiusLg,
        iconSize: 56,
      ),
    );
  }
}

class _ThumbnailStrip extends StatelessWidget {
  const _ThumbnailStrip({
    required this.images,
    required this.swatch,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> images;
  final Color swatch;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double _maxThumb = 76;
  static const double _gap = AppDimensions.spaceSm;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = images.length;
        final fitted = (constraints.maxHeight - _gap * (count - 1)) / count;
        final thumb = fitted.clamp(0.0, _maxThumb);

        return SizedBox(
          width: thumb,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < count; i++)
                _Thumbnail(
                  url: images[i],
                  swatch: swatch,
                  size: thumb,
                  isSelected: i == selectedIndex,
                  onTap: () => onSelected(i),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.url,
    required this.swatch,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final String url;
  final Color swatch;
  final double size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const radius = AppDimensions.radiusSm;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: size,
        height: size,
        transform: Matrix4.translationValues(isSelected ? -6 : 0, 0, 0),
        // padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isSelected ? AppColors.ink : Colors.transparent,
            width: 2,
          ),
        ),
        child: RoundedNetworkImage(
          url: url,
          background: swatch,
          iconSize: 18,
          borderRadius: BorderRadius.circular(radius - 4),
        ),
      ),
    );
  }
}
