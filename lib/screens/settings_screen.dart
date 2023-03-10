import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management/details/app_info_screen.dart';
import 'package:money_management/details/privacy_policy_screen.dart';
import 'package:money_management/details/terms_conditions.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/providers/home_screen_provider.dart';
import 'package:money_management/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('Settings Screen');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const TermsAndConditionsScreen()));
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 14, 69, 113)),
                    child: const Center(
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()));
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 14, 69, 113)),
                    child: const Center(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AppInfoScreen()));
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 14, 69, 113)),
                    child: const Center(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    resetApp(context);
                    TransactionDB.instance.refreshUI();
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .selectedCurrentIndex = 0;
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color.fromARGB(255, 14, 69, 113)),
                    child: const Center(
                      child: Text(
                        'Reset App',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  signOut(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
    await TransactionDB().resetAll();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const SplashScreen()),
        (route) => false);
  }

  resetApp(value) {
    showDialog(
      context: value,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.grey.shade200,
          content: const Text('Reseting app will erase all your data.'),
          title: const Text(
            'Do you want to reset app?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                signOut(context);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }
}
