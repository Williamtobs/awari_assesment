import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductRepository {
  const ProductRepository();

  List<String> categories() => const [
    'Trending',
    'Shoes',
    'Sweatshirts',
    'Shirts',
    'Bags',
  ];

  List<Product> products() => const [
    Product(
      id: 'pullover-hoodie',
      name: "Men' Pullover Hoodie",
      price: 97,
      category: 'Sweatshirts',
      swatch: Color(0xFFD7DAD0),
      imageAspectRatio: 0.74,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=600&q=80',
    ),
    Product(
      id: 'sport-jersey',
      name: "Men's Sport Jersey",
      price: 68,
      category: 'Shirts',
      swatch: Color(0xFFE7E7E4),
      imageAspectRatio: 1.08,
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
    ),
    Product(
      id: 'yoga-crewneck',
      name: 'Yoga Crewneck Sweatshirt',
      price: 42,
      category: 'Sweatshirts',
      swatch: Color(0xFFDCE2E5),
      imageAspectRatio: 1.08,
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=600&q=80',
    ),
    Product(
      id: 'knit-fairway',
      name: "Men's Knit Fairway Cardigan",
      price: 94,
      category: 'Sweatshirts',
      swatch: Color(0xFFE9E5DC),
      imageAspectRatio: 0.74,
      isFavorite: true,
      imageUrl:
          'https://images.unsplash.com/photo-1593030761757-71fae45fa0e7?auto=format&fit=crop&w=600&q=80',
    ),
  ];
}
