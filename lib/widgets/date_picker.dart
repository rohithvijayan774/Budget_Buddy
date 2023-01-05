import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    dateController.text = " ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        controller: dateController,
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
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            print(formattedDate);
            setState(() {
              dateController.text = formattedDate;
            });
          } else {
            print('Date is not selected');
          }
        },
      ),
    );
  }
}
