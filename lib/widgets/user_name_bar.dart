import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserNameBar extends StatefulWidget {
  const UserNameBar({super.key, required this.nameUser});
  final String nameUser;
  @override
  State<UserNameBar> createState() => _UserNameBarState();
}

class _UserNameBarState extends State<UserNameBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 17, right: 17),
      color: const Color.fromARGB(255, 14, 69, 113),
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.nameUser,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
