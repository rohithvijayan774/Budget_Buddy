import 'package:flutter/cupertino.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class StatisticsScreenProvider with ChangeNotifier {
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allCashTransactionList.value;

  List<TransactionModel> chartTransactionNotifier = [];

  int dropDownValue = 0;
  int dropDownValueforFilterSorting = 0;

  void changeStateAllTransaction() {
    chartTransactionNotifier =
        TransactionDB.instance.allCashTransactionList.value;
    notifyListeners();
  }

  void changeStateIncomeNotify() {
    chartTransactionNotifier = TransactionDB.instance.cashIncomeNotifier.value;
    notifyListeners();
  }

  void changeStateExpenseNotify() {
    chartTransactionNotifier = TransactionDB.instance.cashExpenseNotifier.value;
    notifyListeners();
  }

  void setStateOnchanged(value) {
    dropDownValue = value;
    notifyListeners();
  }
}
