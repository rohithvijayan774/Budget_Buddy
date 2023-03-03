import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonProvider with ChangeNotifier {
  TextEditingController dateController = TextEditingController();

  void pickedDateChangeState(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      dateController.text = formattedDate;
    }
  }
}
