import 'package:expenz/constant/colors.dart';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final IncomeCatogary category;
  final String description;
  final DateTime time;
  const IncomeCard(
      {super.key,
      required this.title,
      required this.date,
      required this.amount,
      required this.category,
      required this.description,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: kGrey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 1))
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: incomeCatogaryColor[category]?.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                incomeCatogaryImages[category]!,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBlack.withOpacity(0.8),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+\$${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kGreen,
                ),
              ),
              Text(
                DateFormat.jm().format(date),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
