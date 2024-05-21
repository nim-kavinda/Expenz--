import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:flutter/material.dart';

class IncomeExpenzeCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imgUrl;
  final Color bgColor;
  const IncomeExpenzeCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imgUrl,
    required this.bgColor,
  });

  @override
  State<IncomeExpenzeCard> createState() => _IncomeExpenzeCardState();
}

class _IncomeExpenzeCardState extends State<IncomeExpenzeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kdefaultPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kWhite,
              ),
              child: Center(
                child: Image.asset(
                  widget.imgUrl,
                  width: 70,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                  ),
                ),
                Text(
                  "\$ ${widget.amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
