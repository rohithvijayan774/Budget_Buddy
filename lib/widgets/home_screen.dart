import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_management/screens/first_screen.dart';
import 'package:money_management/screens/settings_screen.dart';
import 'package:money_management/screens/statistics_screen.dart';
import 'package:money_management/screens/transaction_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int selectedCurrentIndex = 0;
  final List _pages = [
    const FirstScreen(),
    const TransactionScreen(),
    const StatisticsScreen(),
    const SettingsScreen()
  ];

  List<Widget> itemsList = [
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

  @override
  void initState() {
    selectedCurrentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: Color.fromARGB(255, 221, 219, 219),
            animationCurve: Curves.easeInOutCubic,
            index: 0,
            height: 50,
            onTap: (index) {
              setState(() {
                selectedCurrentIndex = index;
              });
            },
            items: itemsList),
        body: _pages[selectedCurrentIndex]);
  }
}
