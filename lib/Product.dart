import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.imgUrl,
    required this.name,
    required this.id,
    required this.price,
    required this.fiat,
    required this.colors,
  });
  // Product(this.name, this.id, this.price, this.fiat, this.colors);

  final String imgUrl;
  final String name;
  final String id;
  final int price;
  final String fiat;
  final List<Color> colors;
}