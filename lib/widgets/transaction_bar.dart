import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/providers/transaction_bar_provider.dart';
import 'package:provider/provider.dart';

class TransactionBar extends StatelessWidget {
  const TransactionBar({
    super.key,
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
  });
  final DateTime date;
  final String type;
  final double amount;
  final String category;

  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<TransactionBarProvider>(context);
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
                  Text(parsedDate(date)),
                  Text(
                    type,
                    style: TextStyle(
                        color: type == 'Income' ? Colors.green : Colors.red),
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
                    '₹$amount',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    category,
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
