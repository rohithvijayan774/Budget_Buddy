import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_management/providers/home_screen_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 221, 219, 219),
          animationCurve: Curves.easeInOutCubic,
          index: 0,
          height: 50,
          onTap: (index) {
            Provider.of<HomeScreenProvider>(context, listen: false)
                .changedState(index);
          },
          items: Provider.of<HomeScreenProvider>(context).itemList),
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) {
          return value.pages[value.selectedCurrentIndex];
        },
      ),
    );
  }
}
