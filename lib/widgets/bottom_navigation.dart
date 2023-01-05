import 'package:flutter/material.dart';
import 'package:money_management/screens/home_screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 10,
              selectedItemColor: const Color.fromARGB(255, 14, 69, 113),
              unselectedItemColor: Colors.grey,
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                HomeScreen.selectedIndexNotifier.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.currency_rupee_outlined),
                    label: 'Transactions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet_outlined),
                    label: 'Accounts'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph_sharp), label: 'Statistics'),
              ],
            ),
          ),
        );
      },
    );
  }
}
