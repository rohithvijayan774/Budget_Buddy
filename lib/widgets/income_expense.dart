import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeExpense extends StatefulWidget {
  const IncomeExpense({
    super.key,
    required this.label,
    required this.amount,
  });
  final String label;
  final double amount;

  @override
  State<IncomeExpense> createState() => _IncomeExpenseState();
}

class _IncomeExpenseState extends State<IncomeExpense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 202, 200, 200),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '₹ ${widget.amount}',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
