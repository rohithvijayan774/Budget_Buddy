import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/screens/name_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoUserName();
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
}
