import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class FirtScreenProvider with ChangeNotifier {
  // List<TransactionModel> newTransactionList;

  List<TransactionModel> foundTransactionNotifier = [];

  getAllTransactions() {
    foundTransactionNotifier =
        TransactionDB.instance.allCashTransactionList.value;
    // notifyListeners();
  }

  deleteDialogue(value, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.grey.shade200,
          title: const Text(
            'Do you want to delete?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                TransactionDB.instance.deleteTransactions(value);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
    notifyListeners();
  }
}
