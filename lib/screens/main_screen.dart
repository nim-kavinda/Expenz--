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
      print("Fetch All Expenzes :${expenzeList.length}");
    });
  }

  //Function to fetch all income
  void fetchAllIncome() async {
    List<Income> incomeExpenzes = await IncomeService().loadIncome();
    setState(() {
      incomeList = incomeExpenzes;
      print("Fetch All Income :${incomeList.length}");
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

  //function to remove a expenzes
  void removeExpenzes(Expenze expense) {
    ExpenzeService().deleteExpenzes(expense.id, context);
    setState(() {
      expenzeList.remove(expense);
    });
  }

  //function to remove a income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //category Total expenze
  Map<ExpenzeCategoaries, double> calculateExpenzeCategories() {
    Map<ExpenzeCategoaries, double> categoryTotals = {
      ExpenzeCategoaries.food: 0,
      ExpenzeCategoaries.health: 0,
      ExpenzeCategoaries.shopping: 0,
      ExpenzeCategoaries.subscriptions: 0,
      ExpenzeCategoaries.transport: 0,
    };

    for (Expenze expenze in expenzeList) {
      categoryTotals[expenze.catogary] =
          categoryTotals[expenze.catogary]! + expenze.amount;
    }
    return categoryTotals;
  }

  //category Total income
  Map<IncomeCatogary, double> calculateIncomeCategories() {
    Map<IncomeCatogary, double> categoryTotals = {
      IncomeCatogary.freelance: 0,
      IncomeCatogary.passive: 0,
      IncomeCatogary.salary: 0,
      IncomeCatogary.sales: 0,
    };

    for (Income income in incomeList) {
      categoryTotals[income.catogary] =
          categoryTotals[income.catogary]! + income.amount;
    }
    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    //screenList
    final List<Widget> pages = [
      BudgetScreen(
        expenzecategoryTotal: calculateExpenzeCategories(),
        incomecategoryTotal: calculateIncomeCategories(),
      ),
      HomeScreen(
        incomeList: incomeList,
        expenseList: expenzeList,
      ),
      TransactionScreen(
        omDismisedIncome: removeIncome,
        incomeList: incomeList,
        omDismisedExpenzes: removeExpenzes,
        expenzesList: expenzeList,
      ),
      AddNewScreen(
        addExpenze: addNewExpenzes,
        addIncome: addNewIncome,
      ),
      const ProfileScreen(),
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
