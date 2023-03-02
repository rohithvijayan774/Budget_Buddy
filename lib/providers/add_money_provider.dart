import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class AddMoneyProvider with ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? pickedDate;
  String? categoryController;
  String? typeController;
  TextEditingController noteController = TextEditingController();

  Future<void> addAmountButtonClicked({required context}) async {
    log('button clicked');
    final amount = amountController.text.trim();
    final date = dateController.text;
    final category = categoryController;
    final type = typeController;
    final note = noteController.text;

    if (amount.isEmpty ||
        date.isEmpty ||
        category!.isEmpty ||
        type!.isEmpty ||
        note.isEmpty) {
      return;
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return;
    }

    final addAmount = TransactionModel(
        id: DateTime.now().toString(),
        amount: parsedAmount,
        date: pickedDate!,
        category: category,
        type: type,
        notes: note);

    TransactionDB().insertCashTransactions(addAmount);

    Navigator.of(context).pop();
    notifyListeners();
  }

  void clearField() {
    amountController.clear();
    dateController.clear();
    pickedDate = null;
    categoryController = null;
    typeController = null;
    noteController.clear();
    notifyListeners();
  }
}
