import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:money_management/widgets/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameScreenProvider with ChangeNotifier {
  final guestUser = "Guest";
  TextEditingController nameController = TextEditingController();

  Future<void> submitButtonClicked(context) async {
    final userName = nameController.text.toString();

    if (userName.isNotEmpty) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(SAVE_KEY_NAME, userName);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } else {
      return;
    }
    nameController.clear();
    notifyListeners();
  }

  Future<void> guestButtonClicked(context) async {
    final guest = guestUser.toString();

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(SAVE_KEY_NAME, guest);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
    notifyListeners();
  }
}
