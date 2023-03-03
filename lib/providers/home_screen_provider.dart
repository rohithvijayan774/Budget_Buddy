import 'package:flutter/material.dart';
import 'package:money_management/screens/first_screen.dart';
import 'package:money_management/screens/settings_screen.dart';
import 'package:money_management/screens/statistics_screen.dart';
import 'package:money_management/screens/transaction_screen.dart';

class HomeScreenProvider with ChangeNotifier {
  int selectedCurrentIndex = 0;

  final List pages = [
    const FirstScreen(),
    const TransactionScreen(),
    const StatisticsScreen(),
    const SettingsScreen()
  ];

  List<Widget> itemList = [
    const Icon(
      Icons.home_outlined,
      size: 30,
    ),
    const Icon(
      Icons.currency_rupee_sharp,
      size: 30,
    ),
    const Icon(
      Icons.bar_chart,
      size: 30,
    ),
    const Icon(
      Icons.settings,
      size: 30,
    ),
  ];

  void changedState(int index) {
    selectedCurrentIndex = index;
    notifyListeners();
  }
}
