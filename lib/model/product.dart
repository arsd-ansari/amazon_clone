// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:amazon_clone/model/rating.dart';

class Product {
  final String name;
  final String description;
  final num price;
  final num quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? ratings;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'ratings': ratings
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'],
        description: map['description'],
        price: map['price'],
        quantity: map['quantity'],
        category: map['category'],
        images: List<String>.from((map['images'])),
        id: map['_id'] != null ? map['_id'] ?? '' : null,
        ratings: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
