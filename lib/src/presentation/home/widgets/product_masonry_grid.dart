import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/product.dart';
import 'product_card.dart';

class ProductMasonryGrid extends StatelessWidget {
  const ProductMasonryGrid({
    super.key,
    required this.products,
    this.onFavoriteToggle,
    this.onProductTap,
  });

  final List<Product> products;
  final ValueChanged<Product>? onFavoriteToggle;
  final ValueChanged<Product>? onProductTap;

  @override
  Widget build(BuildContext context) {
    final left = <Product>[];
    final right = <Product>[];
    for (var i = 0; i < products.length; i++) {
      (i.isEven ? left : right).add(products[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _column(left)),
        const SizedBox(width: AppDimensions.spaceMd),
        Expanded(child: _column(right)),
      ],
    );
  }

  Widget _column(List<Product> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: AppDimensions.spaceLg),
          ProductCard(
            product: items[i],
            onTap: () => onProductTap?.call(items[i]),
            onFavoriteToggle: () => onFavoriteToggle?.call(items[i]),
          ),
        ],
      ],
    );
  }
}
