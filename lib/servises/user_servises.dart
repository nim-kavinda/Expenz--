import 'package:expenz/servises/expenze_service.dart';
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

  //method to check wheter the username is saved in the shared prefrences
  static Future<bool> checkUserName() async {
    //create an instance from shared prefrences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName = pref.getString("Username");
    return userName != null;
  }

  //get the user name and the email
  static Future<Map<String, String>> getuserData() async {
    //create an instance for shaerd preference
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userName = pref.getString("username");
    String? email = pref.getString("email");

    return {"username": userName!, "email": email!};
  }

  //remove the username and password
  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('username');
    await pref.remove('email');
  }
}
