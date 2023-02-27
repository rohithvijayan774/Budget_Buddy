import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/screens/search_transactions.dart';
import 'package:money_management/widgets/add_amount.dart';


import 'package:money_management/widgets/transaction_bar.dart';
import 'package:money_management/widgets/transaction_details_screen.dart';

import '../model/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

ValueNotifier<List<TransactionModel>> dateRangeList = ValueNotifier([]);

class _TransactionScreenState extends State<TransactionScreen> {
  // List<TransactionModel> searchTransactions = [];
  bool isSearching = false;
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allCashTransactionList.value;
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
      floatingActionButton: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 50,
            child: FloatingActionButton(
              elevation: 5,
              foregroundColor: const Color.fromARGB(255, 14, 69, 113),
              backgroundColor: Colors.white,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return const AddAmount();
                    },
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return Align(
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: child,
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 1,
                  onTap: () {
                    setState(() {
                      foundTransactionNotifier =
                          TransactionDB.instance.allCashTransactionList.value;
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
                          TransactionDB.instance.cashIncomeNotifier.value;
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
                          TransactionDB.instance.cashExpenseNotifier.value;
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
      ),
      body: ValueListenableBuilder(
        valueListenable: TransactionDB().allCashTransactionList,
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
                              color:const Color.fromARGB(255, 106, 110, 112),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      dropdownValue = 1;
                                      dropdownValueforFilterSorting = 0;
                                      await dateRange();
                                      setState(() {
                                        if (dateRangeList.value.isNotEmpty) {
                                          foundTransactionNotifier =
                                              dateRangeList.value;
                                        } else {
                                          return;
                                        }
                                      });
                                    },
                                    child: const Text('Custom Date'),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 20,
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
                                                deleteDialogue(transaction.id);
                                              },
                                              // onPressed: (context) {
                                              //   TransactionDB.instance
                                              //       .deleteTransactions(
                                              //           transaction.id);
                                              // },
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
                                    height: 15,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      dropdownValue = 1;
                                      dropdownValueforFilterSorting = 0;
                                      await dateRange();
                                      setState(() {
                                        if (dateRangeList.value.isNotEmpty) {
                                          foundTransactionNotifier =
                                              dateRangeList.value;
                                        } else {
                                          return;
                                        }
                                      });
                                    },
                                    child: const Text('Custom Date'))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
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
      results = TransactionDB().allCashTransactionList.value;
    } else {
      results = TransactionDB()
          .allCashTransactionList
          .value
          .where((element) =>
              element.category.toString().contains(enteredKeyword.toString()))
          .toList();
    }
    setState(() {
      foundTransactionNotifier = results;
    });
  }

  deleteDialogue(value) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.grey.shade200,
          title: const Text(
            'Do you want to delete?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                TransactionDB.instance.deleteTransactions(value);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  String parsedDate(DateTime dates) {
    final date = DateFormat.yMMMd().format(dates);
    return date;
  }

  Future<void> dateRange() async {
    dateRangeList.value.clear();
    var daterange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 6),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now(),
        initialDateRange: daterange);
    if (picked != null) {
      final allTrans = await TransactionDB.instance.getTransactions();

      await Future.forEach(allTrans, (TransactionModel transaction) {
        if (transaction.date.isAfter(
              picked.start.subtract(
                const Duration(days: 1),
              ),
            ) &&
            transaction.date.isBefore(
              picked.end.add(
                const Duration(days: 1),
              ),
            )) {
          dateRangeList.value.add(transaction);
          dateRangeList.notifyListeners();
        } else {
          return;
        }
      });
    }
  }
}
