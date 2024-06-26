import 'package:flutter/material.dart';

//income category
enum IncomeCatogary {
  freelance,
  salary,
  passive,
  sales,
}

//category images
final Map<IncomeCatogary, String> incomeCatogaryImages = {
  IncomeCatogary.freelance: "assets/images/freelance.png",
  IncomeCatogary.salary: "assets/images/car.png",
  IncomeCatogary.passive: "assets/images/health.png",
  IncomeCatogary.sales: "assets/images/salary.png",
};

//catogary colors

final Map<IncomeCatogary, Color> incomeCatogaryColor = {
  IncomeCatogary.freelance: const Color(0xffE57373),
  IncomeCatogary.salary: const Color(0xFF81C784),
  IncomeCatogary.passive: const Color(0xFF64B5F6),
  IncomeCatogary.sales: const Color(0xFFFFD54F),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCatogary catogary;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.catogary,
    required this.date,
    required this.time,
    required this.description,
  });

  //Convert the Income object to a JASON object
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': catogary.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create an Income object from a JSON object
  factory Income.fromJSON(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      catogary: IncomeCatogary.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}
