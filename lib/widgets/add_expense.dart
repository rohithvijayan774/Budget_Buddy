import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'category_list.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _expenseAmountController = TextEditingController();
  final _dateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Enter Expense :',
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
                controller: _expenseAmountController,
                decoration: const InputDecoration(
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
                controller: _dateController,
                decoration: const InputDecoration(
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
                'Choose Category :',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CategoryList(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter Note :',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      fromCashButtonClicked();
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'FROM CASH',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      fromBankButtonClicked();
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'FROM BANK',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fromCashButtonClicked() async {
    final expense = _expenseAmountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final note = _noteController.text.trim();
    if (expense.isEmpty || date.isEmpty || category.isEmpty || note.isEmpty) {
      return;
    }
  }

  Future<void> fromBankButtonClicked() async {
    final income = _expenseAmountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final note = _noteController.text.trim();
    if (income.isEmpty || date.isEmpty || category.isEmpty || note.isEmpty) {
      return;
    }
  }
}
