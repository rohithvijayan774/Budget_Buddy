import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountCard extends StatefulWidget {
  const AccountCard(
      {super.key,
      required this.paymentMode,
      required this.totalAmount,
      required this.totalIncome,
      required this.totalExpense});
  final String paymentMode;
  final String totalAmount;
  final String totalIncome;
  final String totalExpense;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 30),
      height: 200,
      width: 250,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 202, 200, 200),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.paymentMode,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              widget.totalAmount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    const Text(
                      'Income',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.totalIncome,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 20,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    const Text(
                      'Expense',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.totalExpense,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
