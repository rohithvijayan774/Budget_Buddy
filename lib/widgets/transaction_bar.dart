// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/splash_screen.dart';

class TransactionBar extends StatefulWidget {
  const TransactionBar(
      {super.key,
      required this.date,
      required this.type,
      required this.amount,
      required this.category});
  final String date;
  final String type;
  final String amount;
  final String category;

  @override
  State<TransactionBar> createState() => _TransactionBarState();
}

class _TransactionBarState extends State<TransactionBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB().allTransactionList,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return Container(
          padding: const EdgeInsets.all(15),
          height: 80,
          width: 500,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 202, 200, 200),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.date),
                  Text(
                    widget.type,
                    style: TextStyle(
                        color: widget.type == 'Income'
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${widget.amount}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.category,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
