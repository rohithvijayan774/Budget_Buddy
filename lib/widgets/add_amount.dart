
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/providers/add_money_provider.dart';
import 'package:provider/provider.dart';

class AddAmount extends StatelessWidget {
  AddAmount({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addMoneyPro = Provider.of<AddMoneyProvider>(context);
    final addMoneyProLF = Provider.of<AddMoneyProvider>(context, listen: false);
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
                  controller: addMoneyPro.amountController,
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
                  controller: addMoneyPro.dateController,
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
                    addMoneyPro.pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (addMoneyPro.pickedDate != null) {
                      addMoneyPro.dateController.text =
                          DateFormat('MMM dd, yyyy')
                              .format(addMoneyPro.pickedDate!);
                      // setState(() {
                      //   // DateFormat format =  DateFormat('yyy-MM-dd');

                      //   addMoneyPro.dateController.text =
                      //       DateFormat('MMM dd, yyyy')
                      //           .format(addMoneyPro.pickedDate!);
                      // });
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
                  value: addMoneyPro.categoryController,
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
                    addMoneyPro.categoryController = value;
                    // setState(
                    //   () {

                    //   },
                    // );
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
                  value: addMoneyPro.typeController,
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
                    addMoneyPro.typeController = value;
                    // setState(() {
                    //   addMoneyPro.typeController = value;
                    // });
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
                  controller: addMoneyPro.noteController,
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
                      addMoneyProLF.addAmountButtonClicked(context: context);
                      addMoneyProLF.clearField();
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
}
