import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertTransactions(TransactionModel value);
  Future<void> deleteTransactions(String transactionID);
}

class TransactionDB implements TransactionDbFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> allTransactionList = ValueNotifier([]);
  @override
  Future<void> insertTransactions(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.add(value);

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
    allTransactionList.value.clear();

    await Future.forEach(
      allTransactions,
      (TransactionModel transaction) {
        allTransactionList.value.add(transaction);
        // if (transaction.category == 'income') {
        //   incomeTransactionList.value.add(transaction);
        // } else {
        //   expenseTransactionList.value.add(transaction);
        // }
      },
    );
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    allTransactionList.notifyListeners();
  }

  @override
  Future<void> deleteTransactions(String transactionID) async {
    final transactionDB = await Hive.openBox(TRANSACTION_DB_NAME);
    await transactionDB.delete(transactionID);
    refreshUI();
  }
}
