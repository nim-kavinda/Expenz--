import 'package:expenz/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String btnName;
  final Color btnColor;

  const CustomBtn({
    super.key,
    required this.btnName,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: btnColor),
      child: Center(
          child: Text(
        btnName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kWhite,
        ),
      )),
    );
  }
}
