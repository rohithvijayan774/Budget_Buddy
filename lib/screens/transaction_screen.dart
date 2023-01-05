import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/widgets/transaction_bar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    TransactionDB().getTransactions().then((value) {
      print('transactions get');
      print(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Transactions',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Stack(
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
                      return const TransactionBar(
                          date: '28/12/2022',
                          type: 'Income',
                          amount: 10000,
                          category: 'Travel');
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
