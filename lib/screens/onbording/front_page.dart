import 'package:expenz/constant/colors.dart';
import 'package:flutter/material.dart';

class FroantPage extends StatelessWidget {
  const FroantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "Expenze",
            style: TextStyle(
              fontSize: 40,
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
