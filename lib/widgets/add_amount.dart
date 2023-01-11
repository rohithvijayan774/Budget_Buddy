import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';

import 'category_list.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _categoryController = TextEditingController();
  // final _typeController = TextEditingController();
  late SingleValueDropDownController _typeController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _typeController = SingleValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Amount'),
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
                  controller: _amountController,
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
                // const CategoryList(),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: _categoryController,
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

                // TextFormField(
                //   textCapitalization: TextCapitalization.sentences,
                //   controller: _typeController,
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
                DropDownTextField(
                  controller: _typeController,
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: 'Income', value: 'Income'),
                    DropDownValueModel(name: 'Expense', value: 'Expense'),
                  ],
                  dropDownItemCount: 2,
                  onChanged: (value) {},
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
                        if (_formKey.currentState!.validate()) {
                          toCashButtonClicked();
                        }
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
      ),
    );
  }

  Future<void> toCashButtonClicked() async {
    final amount = _amountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final type = _typeController.toString().trim();

    if (amount.isEmpty || date.isEmpty || category.isEmpty || type.isEmpty) {
      return;
    }

    final addAmount = TransactionModel(
      id: DateTime.now().toString(),
      amount: amount,
      date: date,
      category: category,
      type: type,
    );
    TransactionDB().insertTransactions(addAmount);

    Navigator.of(context).pop();
  }

  Future<void> toBankButtonClicked() async {
    final income = _amountController.text.trim();
    final date = _dateController.text.trim();
    final category = _categoryController.text.trim();
    final type = _typeController.toString().trim();
    if (income.isEmpty || date.isEmpty || category.isEmpty || type.isEmpty) {
      return;
    }
  }
}
