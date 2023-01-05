import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

import 'package:money_management/widgets/category_list.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _incomeAmountController = TextEditingController();
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
                'Enter Income :',
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
                controller: _incomeAmountController,
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
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      _dateController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
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
              // TextFormField(
              //   controller: _categoryController,
              //   decoration: const InputDecoration(
              //     filled: true,
              //     fillColor: Colors.white,
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(50))),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'This field is required';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
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
                      toCashButtonClicked();
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'TO CASH',
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
                      toBankButtonClicked();
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'TO BANK',
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

  Future<void> toCashButtonClicked() async {
    final income = _incomeAmountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final note = _noteController.text.trim();
    if (income.isEmpty || date.isEmpty || category.isEmpty || note.isEmpty) {
      return;
    }
  }

  Future<void> toBankButtonClicked() async {
    final income = _incomeAmountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final note = _noteController.text.trim();
    if (income.isEmpty || date.isEmpty || category.isEmpty || note.isEmpty) {
      return;
    }
  }
}
