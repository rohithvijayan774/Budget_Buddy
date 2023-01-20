import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/search_transactions.dart';

import 'package:money_management/screens/splash_screen.dart';
import 'package:money_management/widgets/accounts_card.dart';
import 'package:money_management/widgets/add_amount.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  void initState() {
    TransactionDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 14, 69, 113),
        child: const Icon(Icons.add),
        onPressed: () {
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
      body: ListView(
        children: [
          Column(
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
                  children: [
                    const Text(
                      'Balance :',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '₹ ${TransactionDB.instance.addTotalTransaction()[0]}',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const AccountCard(),
              const AccountCard(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
