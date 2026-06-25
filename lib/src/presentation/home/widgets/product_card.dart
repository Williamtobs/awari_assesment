import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/product.dart';
import 'favorite_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: product.imageAspectRatio,
            child: Stack(
              children: [
                Positioned.fill(child: _ProductImage(product: product)),
                Positioned(
                  top: AppDimensions.spaceSm,
                  right: AppDimensions.spaceSm,
                  child: FavoriteButton(
                    isFavorite: product.isFavorite,
                    onTap: onFavoriteToggle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: AppColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        color: product.swatch,
        child: product.imageUrl == null
            ? _placeholder()
            : Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
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
              size: 40,
              color: AppColors.ink.withValues(alpha: 0.25),
            ),
    );
  }
}
