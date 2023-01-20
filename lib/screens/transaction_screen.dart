import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/screens/search_transactions.dart';
import 'package:money_management/screens/splash_screen.dart';

import 'package:money_management/widgets/transaction_bar.dart';
import 'package:money_management/widgets/transaction_details_screen.dart';

import '../model/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // List<TransactionModel> searchTransactions = [];
  bool isSearching = false;
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allTransactionList.value;
  List<TransactionModel> foundTransactionNotifier = [];

  int dropdownValue = 1;
  int dropdownValueforFilterSorting = 0;

  @override
  void initState() {
    TransactionDB().refreshUI();
    foundTransactionNotifier = newTransactionList;
    // searchTransactions = TransactionDB().allTransactionList.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 1,
                  onTap: () {
                    setState(() {
                      foundTransactionNotifier =
                          TransactionDB.instance.allTransactionList.value;
                      dropdownValueforFilterSorting = 0;
                    });
                  },
                  child: const Text('All'),
                ),
                DropdownMenuItem(
                  value: 2,
                  onTap: () {
                    setState(() {
                      foundTransactionNotifier =
                          TransactionDB.instance.incomeNotifier.value;
                      dropdownValueforFilterSorting = 0;
                    });
                  },
                  child: const Text('Income'),
                ),
                DropdownMenuItem(
                  value: 3,
                  onTap: () {
                    setState(() {
                      foundTransactionNotifier =
                          TransactionDB.instance.expenseNotifier.value;
                      dropdownValueforFilterSorting = 0;
                    });
                  },
                  child: const Text('Expense'),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.white,
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),
          ),
        ),
        leadingWidth: 100,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: !isSearching
            ? const Text(
                'Transactions',
                style: TextStyle(fontSize: 25),
              )
            : TextFormField(
                onChanged: (value) {
                  runSearch(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchTransactions(),
                    ),
                  ),
              icon: const Icon(Icons.search))
        ],
        // actions: [
        //   isSearching
        //       ? IconButton(
        //           onPressed: () {
        //             setState(() {
        //               this.isSearching = false;
        //             });
        //           },
        //           icon: const Icon(Icons.close),
        //         )
        //       : IconButton(
        //           onPressed: () {
        //             setState(() {
        //               this.isSearching = true;
        //             });
        //           },
        //           icon: const Icon(Icons.search),
        //         )
        // ],
      ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDB().allTransactionList,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return foundTransactionNotifier.isNotEmpty
              ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            color: const Color.fromARGB(255, 14, 69, 113),
                          ),
                        ],
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
                            // height: 1000,
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
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final transaction =
                                      foundTransactionNotifier[index];
                                  return GestureDetector(
                                    onLongPress: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TransactionDetailsScreen(),
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
                                itemCount: foundTransactionNotifier.length),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            color: const Color.fromARGB(255, 14, 69, 113),
                          ),
                        ],
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
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  void runSearch(String enteredKeyword) {
    List<TransactionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = TransactionDB().allTransactionList.value;
    } else {
      results = TransactionDB()
          .allTransactionList
          .value
          .where((element) =>
              element.category.toString().contains(enteredKeyword.toString()))
          .toList();
    }
    setState(() {
      foundTransactionNotifier = results;
    });
  }
}
