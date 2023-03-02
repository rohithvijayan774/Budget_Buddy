import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money_management/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNameBarProvider with ChangeNotifier {
  var nameValue = '';

  void getValue() async {
    var pref = await SharedPreferences.getInstance();

    var getName = pref.getString(SAVE_KEY_NAME);

    nameValue = getName ?? 'Guest';

    notifyListeners();
  }

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd / MMM');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
