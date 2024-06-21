import 'package:expenz/constant/colors.dart';
import 'package:expenz/models/expenze_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_page.dart';
import 'package:expenz/servises/expenze_service.dart';
import 'package:expenz/servises/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //curent page index
  int _currentPageIndex = 0;

  List<Expenze> expenzeList = [];
  List<Income> incomeList = [];

  //Function to fetch expenzes

  void fetcAllExpenses() async {
    List<Expenze> loadedExpenzes = await ExpenzeService().loadExpenzes();
    setState(() {
      expenzeList = loadedExpenzes;
      print(expenzeList.length);
    });
  }

  //Function to fetch all income
  void fetchAllIncome() async {
    List<Income> incomeExpenzes = await IncomeService().loadIncome();
    setState(() {
      incomeList = incomeExpenzes;
      print(incomeList.length);
    });
  }

  //fonction to add a new expenses
  void addNewExpenzes(Expenze newExpense) {
    ExpenzeService().saveExpenzes(newExpense, context);

    //update the list of expenzes
    setState(() {
      expenzeList.add(newExpense);
    });
  }

  //Function to Add new incomes
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);

    //update the incomeList
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetcAllExpenses();
      fetchAllIncome();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screenList
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(
        addExpenze: addNewExpenzes,
        addIncome: addNewIncome,
      ),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (value) {
          setState(() {
            _currentPageIndex = value;
            print(_currentPageIndex);
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
