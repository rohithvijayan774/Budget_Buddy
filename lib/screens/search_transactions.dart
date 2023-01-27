import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/screens/splash_screen.dart';
import 'package:money_management/screens/transaction_screen.dart';
import 'package:money_management/widgets/transaction_bar.dart';
import 'package:money_management/widgets/transaction_details_screen.dart';

class SearchTransactions extends StatefulWidget {
  const SearchTransactions({super.key});

  @override
  State<SearchTransactions> createState() => _SearchTransactionsState();
}

class _SearchTransactionsState extends State<SearchTransactions> {
  List<TransactionModel> foundTransactions = [];
  @override
  void initState() {
    foundTransactions = TransactionDB().allCashTransactionList.value;
    super.initState();
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
    setState(() {
      foundTransactions = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB().refreshUI();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextFormField(
          onChanged: (value) => runFilter(value),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: 'Search', hintStyle: TextStyle(color: Colors.black26)),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded))
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            color: const Color.fromARGB(255, 14, 69, 113),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 17, 52, 81),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: foundTransactions.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                final transaction = foundTransactions[index];
                                return GestureDetector(
                                  onLongPress: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionDetailsScreen(
                                          date: transaction.date,
                                          type: transaction.type,
                                          amount: transaction.amount,
                                          category: transaction.category,
                                          notes: transaction.notes!,
                                        ),
                                      ),
                                    );
                                    log('long pressed');
                                  },
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation,
                                            Animation<double>
                                                secondaryAnimation) {
                                          return const SplashScreen();
                                        },
                                        transitionsBuilder:
                                            (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secondaryAnimation,
                                                child) {
                                          return Align(
                                            child: SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Slidable(
                                    key: Key(transaction.id),
                                    startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            backgroundColor: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            onPressed: (context) {
                                              TransactionDB.instance
                                                  .deleteTransactions(
                                                      transaction.id);
                                            },
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          )
                                        ]),
                                    child: TransactionBar(
                                        date: transaction.date,
                                        type: transaction.type,
                                        amount: transaction.amount,
                                        category: transaction.category),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: foundTransactions.length)
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/assets/images/emptywallet.png',
                                    scale: 6,
                                    color: Colors.white38,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'No Transactions available',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
