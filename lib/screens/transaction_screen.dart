import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/screens/splash_screen.dart';

import 'package:money_management/widgets/transaction_bar.dart';

import '../model/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isSearching = false;
  @override
  void initState() {
    TransactionDB().refreshUI();
    // TransactionDB().getTransactions().then((value) {
    //   print('transactions get');
    //   print(value.toString());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: !isSearching
            ? const Text(
                'Transactions',
                style: TextStyle(fontSize: 25),
              )
            : TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDB().allTransactionList,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          if (newList.isEmpty) {
            return Center(
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
                        width: 1000,
                        height: 1000,
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
          }
          return Stack(
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
                          final transaction = newList[index];
                          return GestureDetector(
                            // onHorizontalDragStart: (details) {
                            //   log('drag');
                            //   TransactionDB.instance
                            //       .deleteTransactions(transaction.id);
                            // },
                            onLongPress: () {
                              log('long pressed');
                              TransactionDB.instance
                                  .deleteTransactions(transaction.id);
                            },
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return const SplashScreen();
                                  },
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
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
                            child: TransactionBar(
                                date: transaction.date,
                                type: transaction.type,
                                amount: transaction.amount,
                                category: transaction.category),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: newList.length),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
