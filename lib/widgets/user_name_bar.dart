import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNameBar extends StatefulWidget {
  const UserNameBar({super.key});

  @override
  State<UserNameBar> createState() => _UserNameBarState();
}

class _UserNameBarState extends State<UserNameBar> {
  var nameValue = "Guest";
  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 15),
      color: const Color.fromARGB(255, 14, 69, 113),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    nameValue,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                todayDate(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }

  void getValue() async {
    var pref = await SharedPreferences.getInstance();

    var getName = pref.getString(SAVE_KEY_NAME);

    nameValue = getName != null ? getName : "Guest";

    setState(() {});
  }

  String todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd / MMM');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
