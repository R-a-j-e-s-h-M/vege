import 'dart:convert';

import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  final String name;

  final double quantity;
  final List<String>? images;
  final String category;
  final double price;
  final String emaill;
  final String? id;

  Product(
      {required this.name,
      required this.quantity,
      this.images,
      required this.category,
      required this.price,
      required this.emaill,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      "emaill": emaill,
      "id": id
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        emaill: map['emaill'] ?? '',
        id:map['_id']??"");
    
  
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
