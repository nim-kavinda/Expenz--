import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //method to store user nameand user email in shaerd pref
  static Future<void> storeUserDetails({
    required userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //password and confirm password are samed
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and confirm password dont match"),
          ),
        );

        return;
      }
      // create an instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Store the user name and email as key value pair
      await prefs.setString("Username", userName);
      await prefs.setString("email", email);

      //Show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User details Stored Succesfully"),
        ),
      );
    } catch (error) {
      error.toString();
    }
  }
}