import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/search_transactions.dart';
import 'package:money_management/widgets/date_picker.dart';
import 'package:fl_chart/fl_chart.dart';



class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allTransactionList.value;
  List<TransactionModel> chartTransactionNotifier = [];

  int dropdownValue = 0;
  int dropdownValueforFilterSorting = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('STATISTICS'),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            value: dropdownValue,
            items: [
              DropdownMenuItem(
                value: 0,
                child: const Text('All'),
                onTap: () {
                  setState(() {
                    chartTransactionNotifier =
                        TransactionDB.instance.allTransactionList.value;
                  });
                },
              ),
              DropdownMenuItem(
                value: 1,
                child: const Text('Income'),
                onTap: () {
                  setState(() {
                    chartTransactionNotifier =
                        TransactionDB.instance.incomeNotifier.value;
                  });
                },
              ),
              DropdownMenuItem(
                value: 2,
                child: const Text('Expense'),
                onTap: () {
                  setState(() {
                    chartTransactionNotifier =
                        TransactionDB.instance.expenseNotifier.value;
                  });
                },
              ),
            ],
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          )),
        ),
      ),
    // body: dropdownValue !=0
    // ?ValueListenableBuilder(
    //   valueListenable: TransactionDB.instance.allTransactionList, 
    //   builder: (context, value, child) {
    //   return chartTransactionNotifier.isNotEmpty?
    //   Column(children: [Padding(padding: EdgeInsets.only(top: 80),
    //   child: Text(chartTransactionNotifier==
    //   TransactionDB.instance.incomeNotifier.value
    //   ?'Income Statistics'
    //   :'Expense Statistics',
    //   style: TextStyle(
    //     fontWeight: FontWeight.bold,fontSize: 20),
    //     ),
    //   ),
    //   Padding(padding: EdgeInsets.only(top: 80),
    //   child:fl ,)],);
    // },)
    );
  }
}
