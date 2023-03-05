import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class TransactionScreenProvider with ChangeNotifier {
  ValueNotifier<List<TransactionModel>> dateRangeList = ValueNotifier([]);

  bool isSearching = false;
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allCashTransactionList.value;
  List<TransactionModel> foundTransactionNotifier = [];

  int dropDownValue = 1;
  int dropDownValueforFilterSorting = 0;

  void getAllTransactions() {
    TransactionDB.instance.allCashTransactionList;
  }

 filterSortingAllTransaction() {
    log('all transaction');
    foundTransactionNotifier =
        TransactionDB.instance.allCashTransactionList.value;
    dropDownValueforFilterSorting = 0;
    notifyListeners();
  }

  void filterSortingIncomeTransaction() {
    log('income transactions');
    foundTransactionNotifier = TransactionDB.instance.cashIncomeNotifier.value;
    dropDownValueforFilterSorting = 0;
    notifyListeners();
  }

  void filterSortingExpenseTransaction() {
    log('expense transactions');
    foundTransactionNotifier = TransactionDB.instance.cashExpenseNotifier.value;
    dropDownValueforFilterSorting = 0;
    notifyListeners();
  }

  void dropDownSetState(value) {
    dropDownValue = value!;
    notifyListeners();
  }

  void customDateButtonPressed(context) async {
    dropDownValue = 1;
    dropDownValueforFilterSorting = 0;
    await dateRange(context);
    if (dateRangeList.value.isNotEmpty) {
      foundTransactionNotifier = dateRangeList.value;
    } else {
      return;
    }
    notifyListeners();
  }

  void runSearch(String enteredKeyword) {
    List<TransactionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = TransactionDB().allCashTransactionList.value;
    } else {
      results = TransactionDB()
          .allCashTransactionList
          .value
          .where((element) =>
              element.category.toString().contains(enteredKeyword.toString()))
          .toList();
    }
    foundTransactionNotifier = results;
    notifyListeners();
  }

  String parsedDate(DateTime dates) {
    final date = DateFormat.yMMMd().format(dates);
    return date;
  }

  deleteDialogue(value, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                TransactionDB().refreshUI();
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
  }

  Future<void> dateRange(context) async {
    dateRangeList.value.clear();
    var daterange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 6),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now(),
        initialDateRange: daterange);
    if (picked != null) {
      final allTrans = await TransactionDB.instance.getTransactions();

      await Future.forEach(allTrans, (TransactionModel transaction) {
        if (transaction.date.isAfter(
              picked.start.subtract(
                const Duration(days: 1),
              ),
            ) &&
            transaction.date.isBefore(
              picked.end.add(
                const Duration(days: 1),
              ),
            )) {
          dateRangeList.value.add(transaction);
          dateRangeList.notifyListeners();
        } else {
          return;
        }
      });
    }
  }
}
