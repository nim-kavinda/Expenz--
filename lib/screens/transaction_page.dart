import 'package:expenz/Widgets/expenze_card.dart';
import 'package:expenz/Widgets/income_card.dart';
import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/models/expenze_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expenze> expenzesList;
  final List<Income> incomeList;
  final void Function(Expenze) omDismisedExpenzes;
  final void Function(Income) omDismisedIncome;

  const TransactionScreen({
    super.key,
    required this.expenzesList,
    required this.omDismisedExpenzes,
    required this.incomeList,
    required this.omDismisedIncome,
  });

  @override
  State<TransactionScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kdefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "See Your Finacial Reprt",
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Expenzes",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Show all the Expenzes
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expenzesList.length,
                        itemBuilder: (context, index) {
                          final expenze = widget.expenzesList[index];

                          return Dismissible(
                            key: ValueKey(expenze),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.omDismisedExpenzes(expenze);
                              });
                            },
                            child: ExpenzeCard(
                              title: expenze.title,
                              date: expenze.date,
                              amount: expenze.amount,
                              category: expenze.catogary,
                              description: expenze.description,
                              time: expenze.time,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const Text(
                "Income",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Show all the Expenzes
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.incomeList.length,
                        itemBuilder: (context, index) {
                          final income = widget.incomeList[index];

                          return Dismissible(
                            key: ValueKey(income),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.omDismisedIncome(income);
                              });
                            },
                            child: IncomeCard(
                              title: income.title,
                              date: income.date,
                              amount: income.amount,
                              category: income.catogary,
                              description: income.description,
                              time: income.time,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
