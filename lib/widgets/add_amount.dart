import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

class AddAmount extends StatefulWidget {
  const AddAmount({super.key});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  String? _categoryController;
  String? _typeController;
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Amount',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 14, 69, 113),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const Text(
                  'Enter Amount :',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: amountController,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Select Date :',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: 'Pick a date',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  onTap: () async {
                    pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        // DateFormat format =  DateFormat('yyy-MM-dd');

                        dateController.text =
                            DateFormat('MMM dd, yyyy').format(pickedDate!);
                      });
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Choose Category :',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                  hint: const Text('Categories...'),
                  value: _categoryController,
                  items: const [
                    DropdownMenuItem(
                      value: 'Travel',
                      child: Text('Travel'),
                    ),
                    DropdownMenuItem(
                      value: 'Entertainment',
                      child: Text('Entertainment'),
                    ),
                    DropdownMenuItem(
                      value: 'Food/Drink',
                      child: Text('Food/Drink'),
                    ),
                    DropdownMenuItem(
                      value: 'Rent',
                      child: Text('Rent'),
                    ),
                    DropdownMenuItem(
                      value: 'Loan',
                      child: Text('Loan'),
                    ),
                    DropdownMenuItem(
                      value: 'Salary',
                      child: Text('Salary'),
                    ),
                    DropdownMenuItem(
                      value: 'Commission',
                      child: Text('Commission'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(
                      () {
                        _categoryController = value;
                      },
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Select Type :',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                  hint: const Text('Select Type'),
                  value: _typeController,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'Income',
                      child: Text('Income'),
                    ),
                    DropdownMenuItem(
                      value: 'Expense',
                      child: Text('Expense'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _typeController = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter Note : ',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: noteController,
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      toCashButtonClicked();
                    }
                  },
                  child: const Text(
                    'ADD AMOUNT',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> toCashButtonClicked() async {
    final amount = amountController.text.trim();
    final date = dateController.text;
    final category = _categoryController;
    final type = _typeController;
    final note = noteController.text;

    if (amount.isEmpty ||
        date.isEmpty ||
        category!.isEmpty ||
        type!.isEmpty ||
        note.isEmpty) {
      return;
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return;
    }

    final addAmount = TransactionModel(
        id: DateTime.now().toString(),
        amount: parsedAmount,
        date: pickedDate!,
        category: category,
        type: type,
        notes: note);

    TransactionDB().insertCashTransactions(addAmount);

    Navigator.of(context).pop();
    setState(() {});
  }
}
