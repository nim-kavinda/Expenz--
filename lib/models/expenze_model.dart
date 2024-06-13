// enum for expenze catogary

import 'package:flutter/material.dart';

enum ExpenzeCategoaries {
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

//category images
final Map<ExpenzeCategoaries, String> expenzeCategoariesImages = {
  ExpenzeCategoaries.food: "assets/images/restaurant.png",
  ExpenzeCategoaries.transport: "assets/images/car.png",
  ExpenzeCategoaries.health: "assets/images/health.png",
  ExpenzeCategoaries.shopping: "assets/images/bag.png",
  ExpenzeCategoaries.subscriptions: "assets/images/bill.png",
};

//category colors
final Map<ExpenzeCategoaries, Color> expenzeCategoariesColors = {
  ExpenzeCategoaries.food: const Color(0xFFE57373),
  ExpenzeCategoaries.transport: const Color(0xFF81C784),
  ExpenzeCategoaries.health: const Color(0xFF64B5F6),
  ExpenzeCategoaries.shopping: const Color(0xFFFFD54F),
  ExpenzeCategoaries.subscriptions: const Color(0xFF9575CD),
};

//model
class Expenze {
  final int id;
  final String title;
  final double amount;
  final ExpenzeCategoaries catogary;
  final DateTime date;
  final DateTime time;
  final String description;

  Expenze({
    required this.id,
    required this.title,
    required this.amount,
    required this.catogary,
    required this.date,
    required this.time,
    required this.description,
  });
}
