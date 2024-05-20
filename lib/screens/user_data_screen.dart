import 'package:flutter/material.dart';

class UsaerDataScreen extends StatefulWidget {
  const UsaerDataScreen({super.key});

  @override
  State<UsaerDataScreen> createState() => _UsaerDataScreenState();
}

class _UsaerDataScreenState extends State<UsaerDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Data"),
      ),
    );
  }
}
