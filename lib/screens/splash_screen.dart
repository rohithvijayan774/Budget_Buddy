import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/main.dart';
import 'package:money_management/screens/home_screen.dart';
import 'package:money_management/screens/name_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String message = DateTime.now().hour < 12
      ? "Good Morning"
      : DateTime.now().hour < 15
          ? "Good Afternoon"
          : "Good Evening";
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/icons/wallet.png',
          scale: 2,
        ),
      ),
    );
  }

  Future<void> gotoUserName() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => NameScreen(),
      ),
    );
  }

  Future<void> checkUserLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggenin = sharedPrefs.getString(SAVE_KEY_NAME);
    if (userLoggenin == null || userLoggenin.isEmpty) {
      gotoUserName();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => HomeScreen()));
    }
  }
}
