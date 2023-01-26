import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen(
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
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 150,
          bottom: 150,
          left: 30,
          right: 30,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color.fromARGB(255, 14, 69, 113),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Amount : ₹${widget.amount}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Type : ${widget.type}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Date : ${parsedDate(widget.date)}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Category : ${widget.category}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String parsedDate(DateTime dates) {
    final date = DateFormat.yMMMd().format(dates);
    return date;
  }
}
