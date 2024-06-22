import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //Define the key from storing income in shared prefrences

  static const String _incomeKey = 'income';

  //save the income to shared preferences

  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      List<String>? existingIncomes = pref.getStringList(_incomeKey);

      //Convert the existing expenzes to a list of Expenzes objects
      List<Income> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
      }

      //Add the new income to the list
      existingIncomeObjects.add(income);

      //convert the list of income objects back to a list of strings
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //save the updated list of expenzes to shared prefrences
      await pref.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Income Added Succesfully!",
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Error on Adding income!",
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expenzes from the shared prefrences
  Future<List<Income>> loadIncome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingincome = pref.getStringList(_incomeKey);

    //Convert the Existing income to a list of income objects
    List<Income> loadedIncome = [];

    if (existingincome != null) {
      loadedIncome =
          existingincome.map((e) => Income.fromJSON(json.decode(e))).toList();
    }
    return loadedIncome;
  }

  //function delete income service

  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncome = pref.getStringList(_incomeKey);

      //Convert the Existing income to a list of income objects
      List<Income> existingIncomeObjects = [];

      if (existingIncome != null) {
        existingIncomeObjects = existingIncome
            .map((e) => Income.fromJSON(json.decode((e))))
            .toList();
      }

      // remove the income with the given id from the list
      existingIncomeObjects.removeWhere((income) => income.id == id);

      //convert the list of income objects back to a list of strings
      List<String> UpdateddIncome =
          existingIncomeObjects.map((e) => json.encode(e)).toList();

      //Save the updated list of expenzes to shared prefrences
      await pref.setStringList(_incomeKey, UpdateddIncome);

      //Show massege

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Income Deleted Succesfull"),
          duration: Duration(
            seconds: 3,
          ),
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error Deleting Income"),
          duration: Duration(
            seconds: 3,
          ),
        ));
      }
    }
  }
}
