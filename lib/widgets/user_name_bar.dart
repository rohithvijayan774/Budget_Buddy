import 'package:flutter/material.dart';
import 'package:money_management/providers/user_name_bar_provider.dart';
import 'package:provider/provider.dart';

class UserNameBar extends StatelessWidget {
  const UserNameBar({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserNameBarProvider>(context).getValue();
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
                    Provider.of<UserNameBarProvider>(context).nameValue,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                Provider.of<UserNameBarProvider>(context).todayDate(),
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
}
