import 'package:expenz/Widgets/profile_card.dart';
import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/screens/onbording_screens.dart';
import 'package:expenz/servises/expenze_service.dart';
import 'package:expenz/servises/income_service.dart';
import 'package:expenz/servises/user_servises.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String email = '';

  @override
  void initState() {
    UserServices.getuserData().then(
      (value) {
        if (value['username'] != null && value['email'] != null) {
          setState(() {
            userName = value['username']!;
            email = value['email']!;
          });
        }
      },
    );
    super.initState();
  }

  //open scaffold mesenger for logout
  void _showbottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(
            kdefaultPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are You Sure You Want to Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kGreen,
                      ),
                    ),
                    onPressed: () async {
                      //Clear the user data
                      await UserServices.clearUserData();

                      //clear the all expenzes
                      if (context.mounted) {
                        await ExpenzeService().deleteAllExpenzes(context);
                        await IncomeService().deleteAllIncome(context);
                        //navigate to the onbording Screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnbordingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: Text(
                      "yes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kRed,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kdefaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kMainColor,
                        border: Border.all(
                          color: kMainColor,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.asset(
                          "assets/images/user.jpg",
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ${userName} ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Welcome ${email} ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: kMainColor,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                const ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kGreen,
                ),
                GestureDetector(
                  onTap: () {
                    _showbottomSheet(context);
                  },
                  child: const ProfileCard(
                    icon: Icons.logout,
                    title: "Logout",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
