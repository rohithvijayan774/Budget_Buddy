import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/providers/first_screen_provider.dart';
import 'package:money_management/providers/transaction_screen_provider.dart';
import 'package:money_management/screens/splash_screen.dart';

import 'package:money_management/widgets/transaction_bar.dart';
import 'package:money_management/widgets/transaction_details_screen.dart';
import 'package:money_management/widgets/user_name_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/income_expense.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  // @override
  // void initState() {
  //   TransactionDB.instance.refreshUI();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    log('Home Screen');
    final pro = Provider.of<FirtScreenProvider>(context);
    final proLF = Provider.of<FirtScreenProvider>(context, listen: false);
    proLF.getAllTransactions();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'BUDGET BUDDY',
            style: GoogleFonts.alef(textStyle: const TextStyle(fontSize: 30)),
          ),
        ),
        body: ListView(
          children: [
            // ValueListenableBuilder(
            //   valueListenable: TransactionDB().allCashTransactionList,
            //   builder:
            //       (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
            Column(
              children: [
                const UserNameBar(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 17,
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 14, 69, 113),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                  ),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Balance',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '₹ ${TransactionDB.instance.addTotalTransaction()[0]}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 14, 69, 113),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 5),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ],
                        ),
                        child: const IncomeExpenseHomePage(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Recent Transactions :',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 35, left: 10, right: 10),
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Color.fromARGB(255, 14, 69, 113),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              spreadRadius: 5)
                        ],
                      ),
                      child: Consumer<FirtScreenProvider>(
                        builder: (context, value, child) {
                          if (pro.foundTransactionNotifier.isEmpty) {
                            return const Center(
                              child: Text(
                                'No transactions available',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white60),
                              ),
                            );
                          }

                          return ListView.separated(
                            itemBuilder: (context, index) {
                              final transaction =
                                  pro.foundTransactionNotifier[index];
                              // final transaction = newTransactionList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return TransactionDetailsScreen(
                                          date: transaction.date,
                                          type: transaction.type,
                                          amount: transaction.amount,
                                          category: transaction.category,
                                          notes: transaction.notes!,
                                        );
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
                                            proLF.deleteDialogue(
                                                transaction.id, context);
                                          },
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        )
                                      ]),
                                  child: Center(
                                    child: TransactionBar(
                                      date: transaction.date,
                                      type: transaction.type,
                                      amount: transaction.amount,
                                      category: transaction.category,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: (pro.foundTransactionNotifier.length < 3
                                ? pro.foundTransactionNotifier.length
                                : 3),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],

              // },
            ),
          ],
        ));
  }

  // signOut(BuildContext ctx) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   await sharedPrefs.clear();
  //   await TransactionDB().resetAll();
  //   Navigator.of(ctx).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (ctx1) => const SplashScreen()),
  //       (route) => false);
  // }

  // deleteDialogue(value, context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         backgroundColor: Colors.grey.shade200,
  //         title: const Text(
  //           'Do you want to delete?',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text(
  //               'No',
  //               style: TextStyle(color: Colors.black),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               TransactionDB.instance.deleteTransactions(value);
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text(
  //               'Yes',
  //               style: TextStyle(color: Colors.black),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // resetApp(value) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         backgroundColor: Colors.grey.shade200,
  //         content: const Text('Reseting app will erase all your data.'),
  //         title: const Text(
  //           'Do you want to reset app?',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('No'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               signOut(context);
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Yes'),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
