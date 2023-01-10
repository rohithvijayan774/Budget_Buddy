import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertTransactions(TransactionModel value);
}

class TransactionDB implements TransactionDbFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  // ValueNotifier<List<TransactionModel>> incomeTransactionList =
  //     ValueNotifier([]);
  // ValueNotifier<List<TransactionModel>> expenseTransactionList =
  //     ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> allTransactionList = ValueNotifier([]);
  @override
  Future<void> insertTransactions(TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.add(value);

    refreshUI();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allTransactions = await getTransactions();
    allTransactionList.value.clear();
    // incomeTransactionList.value.clear();
    // expenseTransactionList.value.clear();
    await Future.forEach(
      _allTransactions,
      (TransactionModel transaction) {
        allTransactionList.value.add(transaction);
        // if (transaction.category == 'income') {
        //   incomeTransactionList.value.add(transaction);
        // } else {
        //   expenseTransactionList.value.add(transaction);
        // }
      },
    );
    allTransactionList.notifyListeners();
    // incomeTransactionList.notifyListeners();
    // expenseTransactionList.notifyListeners();
  }
}
