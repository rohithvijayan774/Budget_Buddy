import 'package:flutter/cupertino.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class SearchTransactionsProvider with ChangeNotifier {
  List<TransactionModel> foundTransactions = [];

  void initialState() {
    foundTransactions = TransactionDB().allCashTransactionList.value;
    // notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<TransactionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = TransactionDB().allCashTransactionList.value;
    } else {
      results = TransactionDB()
          .allCashTransactionList
          .value
          .where((element) => element.category
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    foundTransactions = results;
    notifyListeners();
  }
}
