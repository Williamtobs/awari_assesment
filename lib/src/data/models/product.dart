import 'package:flutter/widgets.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.swatch,
    this.imageUrl,
    this.isFavorite = false,
    this.imageAspectRatio = 0.82,
    this.description = '',
    this.gallery = const [],
    this.sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'],
  });

  final String id;
  final String name;
  final double price;
  final String category;

  final String? imageUrl;
  final Color swatch;
  final bool isFavorite;
  final double imageAspectRatio;

  final String description;
  final List<String> gallery;
  final List<String> sizes;

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

  String get euroPrice => '€${price.toStringAsFixed(0)}';

  List<String> get images {
    if (gallery.isNotEmpty) return gallery;
    if (imageUrl != null) return [imageUrl!];
    return const [];
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      price: price,
      category: category,
      swatch: swatch,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      imageAspectRatio: imageAspectRatio,
      description: description,
      gallery: gallery,
      sizes: sizes,
    );
  }
}
