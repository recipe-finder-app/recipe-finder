import 'package:flutter/material.dart';

class IngredientModel {
  final String title;
  final String? imagePath;
  final Color? color;
  final double? quantity;
  final String? type;

  IngredientModel({
    this.color,
    this.imagePath,
    required this.title,
    this.quantity,
    this.type,
  });
}
