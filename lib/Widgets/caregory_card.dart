import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double totle;
  final Color progresColor;
  final bool isExpenzes;
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.totle,
    required this.progresColor,
    required this.isExpenzes,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressWidth = widget.totle != 0
        ? MediaQuery.of(context).size.width * (widget.amount / widget.totle)
        : 0;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(kdefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: kBlack.withOpacity(0.1),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.progresColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: kBlack,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${(widget.amount / widget.totle * 100).toStringAsFixed(2)}%",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${widget.amount.toStringAsFixed(2)}\$",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: widget.isExpenzes ? kRed : kGreen,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),

          //liner progrss bar
          Container(
            height: 10,
            width: progressWidth,
            decoration: BoxDecoration(
              color: widget.progresColor,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}
