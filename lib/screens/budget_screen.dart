import 'package:expenz/Widgets/caregory_card.dart';
import 'package:expenz/Widgets/pi_chart.dart';
import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/models/expenze_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenzeCategoaries, double> expenzecategoryTotal;
  final Map<IncomeCatogary, double> incomecategoryTotal;
  const BudgetScreen({
    super.key,
    required this.expenzecategoryTotal,
    required this.incomecategoryTotal,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  //method to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenzeCategoaries) {
      return expenzeCategoariesColors[category]!;
    } else {
      return incomeCatogaryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenzecategoryTotal
        : widget.incomecategoryTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Report",
          style: TextStyle(
            color: kBlack,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kdefaultPadding,
                  vertical: kdefaultPadding / 2,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedOption == 1 ? kWhite : kRed,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 60,
                          ),
                          child: Text(
                            "Expenze",
                            style: TextStyle(
                              color: _selectedOption == 0 ? kWhite : kBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedOption == 0 ? kWhite : kGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 60,
                          ),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: _selectedOption == 1 ? kWhite : kBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Pi Chart
              Chart(
                expenzecategoryTotal: widget.expenzecategoryTotal,
                incomecategoryTotal: widget.incomecategoryTotal,
                isExpenze: _selectedOption == 0,
              ),
              const SizedBox(
                height: 20,
              ),
              //List of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final t = data.values.toList()[index];

                    return CategoryCard(
                      title: category.name,
                      amount: t,
                      totle: data.values
                          .reduce((value, element) => value + element),
                      progresColor: getCategoryColor(category),
                      isExpenzes: _selectedOption == 0,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
