import 'package:expenz/Widgets/wrapper.dart';
import 'package:expenz/screens/onbording_screens.dart';
import 'package:expenz/servises/user_servises.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.checkUserName(),
      builder: (context, snapshot) {
        //if the snapshot is still wating
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          // here the hasUserName will be set to true of the data is thir in the snapshot and otherwise flase
          bool hasUserName = snapshot.data ?? false;
          return MaterialApp(
              title: "Expenze",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "Inter",
              ),
              home: Wrapper(
                showMainScreen: hasUserName,
              ));
        }
      },
    );
  }
}
