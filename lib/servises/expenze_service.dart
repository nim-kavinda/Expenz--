import 'dart:convert';

import 'package:expenz/models/expenze_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenzeService {
  //expenze list

  //List<Expenze> expenzeList = [];

  //Define the key from storing expenses in shared prefrences

  static const String _expenzeKey = 'expenses';

  //save the expense to shared preferences
  Future<void> saveExpenzes(Expenze expenze, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenzes = prefs.getStringList(_expenzeKey);

      //Convert the existing expenzes to a list of Expenzes objects
      List<Expenze> existingExpenzeObject = [];

      if (existingExpenzes != null) {
        existingExpenzeObject = existingExpenzes
            .map((e) => Expenze.fromJSON(json.decode(e)))
            .toList();
      }

      //Add the new expenzes to the list
      existingExpenzeObject.add(expenze);

      //convert the list of expense objects back to a list of strings
      List<String> updatateExpenzes =
          existingExpenzeObject.map((e) => json.encode(e.toJSON())).toList();

      //save the updated list of expenzes to shared prefrences

      await prefs.setStringList(_expenzeKey, updatateExpenzes);

      // show massage
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expenze Added succsfull"),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      }
    } catch (err) {
      // show massage
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding Expenzes!"),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      }
    }
  }

  loadExpenzes() {}

  //Load the expenzes from the shared prefrences
}
