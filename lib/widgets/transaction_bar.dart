import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class TransactionBar extends StatefulWidget {
  const TransactionBar(
      {super.key,
      required this.date,
      required this.type,
      required this.amount,
      required this.category});
  final DateTime date;
  final String type;
  final double amount;
  final String category;

  @override
  State<TransactionBar> createState() => _TransactionBarState();
}

class _TransactionBarState extends State<TransactionBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB().allCashTransactionList,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.width / 4,
          width: MediaQuery.of(context).size.width,
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
                  Text(parsedDate(widget.date)),
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
                height: 20,
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

  String parsedDate(DateTime dates) {
    final date = DateFormat.yMMMd().format(dates);
    return date;
  }
}
