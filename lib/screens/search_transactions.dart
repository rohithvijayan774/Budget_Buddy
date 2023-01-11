import 'package:flutter/material.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/screens/transaction_screen.dart';

class SearchTransactions extends StatefulWidget {
  const SearchTransactions({super.key});

  @override
  State<SearchTransactions> createState() => _SearchTransactionsState();
}

class _SearchTransactionsState extends State<SearchTransactions> {
  List<TransactionModel> foundTransactions = [];
  @override
  void initState() {
    foundTransactions = TransactionDB().allTransactionList.value;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<TransactionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = TransactionDB().allTransactionList.value;
    } else {
      results = TransactionDB()
          .allTransactionList
          .value
          .where((element) => element.category
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTransactions = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB().refreshUI();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Transactions'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            onChanged: (value) => runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          Expanded(child: TransactionScreen())
        ],
      )),
    );
  }
}
