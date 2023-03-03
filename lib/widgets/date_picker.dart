import 'package:flutter/material.dart';
import 'package:money_management/providers/common_provider.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        controller: Provider.of<CommonProvider>(context).dateController,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        readOnly: true,
        onTap: () async {
          Provider.of<CommonProvider>(context, listen: false)
              .pickedDateChangeState(context);
        },
      ),
    );
  }
}
