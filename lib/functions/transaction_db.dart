import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertCashTransactions(TransactionModel value);
  Future<void> insertBankTransactions(TransactionModel value);
  Future<void> deleteTransactions(String transactionID);
  Future<void> resetAll();
}

class TransactionDB implements TransactionDbFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> allCashTransactionList =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> allBankTransactionList =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> cashIncomeNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> cashExpenseNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> bankExpenseNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> bankIncomeNotifier = ValueNotifier([]);

  @override
  Future<void> insertCashTransactions(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.put(value.id, value);

    refreshUI();
  }

  @override
  Future<void> insertBankTransactions(TransactionModel value) async {
    final TransactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await TransactionDB.put(value.id, value);

    refreshUI();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allTransactions = await getTransactions();
    allTransactions.sort((first, second) => second.date.compareTo(first.date));
    allCashTransactionList.value.clear();
    allCashTransactionList.value.addAll(allTransactions);
    cashIncomeNotifier.value.clear();
    cashExpenseNotifier.value.clear();
    await Future.forEach(
      allTransactions,
      (TransactionModel transaction) {
        // allTransactionList.value.add(transaction);
        if (transaction.type == 'Income') {
          cashIncomeNotifier.value.add(transaction);
        } else {
          cashExpenseNotifier.value.add(transaction);
        }
      },
    );
    allCashTransactionList.notifyListeners();
    cashIncomeNotifier.notifyListeners();
    cashExpenseNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransactions(String transactionID) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.delete(transactionID);
    refreshUI();
  }

  @override
  Future<void> resetAll() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDB.clear();
    refreshUI();
    log('Reset All');
  }

  List totalAllNotifier = [];

  List addTotalTransaction() {
    double? newExpenseAmount = 0;
    double? newIncomeAmount = 0;
    double? total = 0;

    for (var i = 0; i < allCashTransactionList.value.length; i++) {
      var values = allCashTransactionList.value[i];

      if (values.type == 'Income') {
        newIncomeAmount = newIncomeAmount! + values.amount;
      } else {
        newExpenseAmount = newExpenseAmount! + values.amount;
      }
      total = newIncomeAmount! - newExpenseAmount!;
    }
    totalAllNotifier.add(newIncomeAmount);
    totalAllNotifier.add(newExpenseAmount);

    return [total!, newExpenseAmount!, newIncomeAmount!];
  }
}
