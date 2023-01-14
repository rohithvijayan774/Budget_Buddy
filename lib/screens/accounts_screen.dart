import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

import 'package:money_management/screens/splash_screen.dart';
import 'package:money_management/widgets/accounts_card.dart';
import 'package:money_management/widgets/add_amount.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 14, 69, 113),
        child: const Icon(Icons.add),
        onPressed: () {
          // final _sample = TransactionModel(
          //   id: '1',
          //   incomeAmount: '10000',
          //   date: DateTime.now().toString(),
          //   category: 'Travel',
          //   note: 'Travel Expense',
          // );
          // TransactionDB().insertTransactions(_sample);
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return const AddIncome();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Accounts',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            padding: const EdgeInsets.all(10),
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 14, 69, 113),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Balance :',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '₹ 0.00',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const AccountCard(
              paymentMode: 'CASH',
              totalAmount: '10,000',
              totalIncome: '20,000',
              totalExpense: '10,000'),
          const AccountCard(
              paymentMode: 'BANK',
              totalAmount: '1,00,000',
              totalIncome: '2,00,000',
              totalExpense: '1,00,000'),
          const SizedBox(
            height: 40,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         shape: const StadiumBorder(),
          //         textStyle: const TextStyle(fontSize: 18),
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          //         backgroundColor: const Color.fromARGB(255, 14, 69, 113),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => const AddIncome(),
          //           ),
          //         );
          //       },
          //       child: const Text('ADD INCOME'),
          //     ),
          //     ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         shape: const StadiumBorder(),
          //         textStyle: const TextStyle(fontSize: 18),
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          //         backgroundColor: const Color.fromARGB(255, 14, 69, 113),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => const AddExpense(),
          //           ),
          //         );
          //       },
          //       child: const Text('ADD EXPENSE'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
