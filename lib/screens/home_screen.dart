import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts_screen.dart';
import 'package:money_management/screens/first_screen.dart';
import 'package:money_management/screens/statistics_screen.dart';
import 'package:money_management/screens/transaction_screen.dart';
import 'package:money_management/widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    FirstScreen(),
    TransactionScreen(),
    AccountsScreen(),
    StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
    );
  }
}
