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
  });

  final String id;
  final String name;
  final double price;
  final String category;

  final String? imageUrl;
  final Color swatch;
  final bool isFavorite;
  final double imageAspectRatio;

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

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
    );
  }
}
