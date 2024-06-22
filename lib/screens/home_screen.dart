import 'package:expenz/Widgets/expenze_card.dart';
import 'package:expenz/Widgets/income_expenze_card.dart';
import 'package:expenz/Widgets/line_chart.dart';
import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/models/expenze_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/servises/user_servises.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  final List<Expenze> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the user name
  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    //get the user name from the shaerd prefrence
    UserServices.getuserData().then(
      (value) {
        if (value["username"] != null) {
          setState(() {
            userName = value['username']!;
            print(userName);
          });
        }
      },
    );
    setState(() {
      //total amont of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal = expenseTotal + widget.expenseList[i].amount;
      }
      //total amont of income
      for (var i = 0; i < widget.incomeList.length; i++) {
        incomeTotal = incomeTotal + widget.incomeList[i].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main Column

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //bg color container
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
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
                          Text(
                            "Welcome $userName ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenzeCard(
                            amount: expenseTotal,
                            bgColor: kGreen,
                            imgUrl: "assets/images/income.png",
                            title: "Income",
                          ),
                          IncomeExpenzeCard(
                            amount: incomeTotal,
                            bgColor: kRed,
                            imgUrl: "assets/images/expense.png",
                            title: "Expenze",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //Line Chart
              const Padding(
                padding: EdgeInsets.all(
                  kdefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequncy",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LineChartSample(),
                  ],
                ),
              ),
              //recent transaction
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kdefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "recent trastarction",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        widget.expenseList.isEmpty
                            ? const Text(
                                "No Expenzes Added Yet.Add Some Expenzes See Here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.expenseList.length,
                                itemBuilder: (context, index) {
                                  final expenze = widget.expenseList[index];

                                  return ExpenzeCard(
                                    title: expenze.title,
                                    date: expenze.date,
                                    amount: expenze.amount,
                                    category: expenze.catogary,
                                    description: expenze.description,
                                    time: expenze.time,
                                  );
                                },
                              ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
