// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String userId;
  final int orderedAt;
  final String address;
  final int status;
  final num totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.userId,
    required this.orderedAt,
    required this.address,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'userId': userId,
      'orderedAt': orderedAt,
      'address': address,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        (map['products'])?.map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as int,
      address: map['address'] as String,
      status: map['status'] as int,
      totalPrice: map['totalPrice'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
