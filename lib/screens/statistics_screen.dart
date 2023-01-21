import 'package:flutter/material.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/search_transactions.dart';
import 'package:money_management/widgets/date_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<TransactionModel> newTransactionList =
      TransactionDB.instance.allCashTransactionList.value;
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
                        TransactionDB.instance.allCashTransactionList.value;
                  });
                },
              ),
              DropdownMenuItem(
                value: 1,
                child: const Text('Income'),
                onTap: () {
                  setState(() {
                    chartTransactionNotifier =
                        TransactionDB.instance.cashIncomeNotifier.value;
                  });
                },
              ),
              DropdownMenuItem(
                value: 2,
                child: const Text('Expense'),
                onTap: () {
                  setState(() {
                    chartTransactionNotifier =
                        TransactionDB.instance.cashExpenseNotifier.value;
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
      body: ListView(
        children: [
          dropdownValue != 0
              ? ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.allCashTransactionList,
                  builder: (context, value, child) {
                    return chartTransactionNotifier.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: Text(
                                  chartTransactionNotifier ==
                                          TransactionDB
                                              .instance.cashIncomeNotifier.value
                                      ? 'Income Statistics'
                                      : 'Expense Statistics',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: SfCircularChart(
                                  enableMultiSelection: true,
                                  legend: Legend(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    backgroundColor: Colors.black12,
                                    isResponsive: true,
                                    position: LegendPosition.right,
                                    toggleSeriesVisibility: true,
                                    isVisible: true,
                                    overflowMode: LegendItemOverflowMode.scroll,
                                  ),
                                  series: <CircularSeries>[
                                    PieSeries<TransactionModel, String>(
                                      explode: true,
                                      dataSource: chartTransactionNotifier,
                                      xValueMapper:
                                          (TransactionModel data, _) =>
                                              data.category,
                                      yValueMapper: (TransactionModel data, _) {
                                        return data.amount;
                                      },
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: const [
                              Icon(
                                Icons.add_to_photos,
                                size: 50,
                                color: Colors.black12,
                              ),
                              Text(
                                'No Transaction available!',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black26,
                                ),
                              ),
                            ],
                          );
                  },
                )
              : TransactionDB.instance.allCashTransactionList.value.isNotEmpty
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Text(
                            'Overall Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 130),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: PieChart(
                                  PieChartData(
                                    centerSpaceRadius: 0,
                                    sectionsSpace: 2,
                                    sections: [
                                      PieChartSectionData(
                                        titleStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        title: TransactionDB.instance
                                            .addTotalTransaction()[1]
                                            .toString(),
                                        value: TransactionDB.instance
                                            .addTotalTransaction()[1],
                                        color: Colors.red.shade400,
                                        radius: 100,
                                      ),
                                      PieChartSectionData(
                                        titleStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        title: TransactionDB.instance
                                            .addTotalTransaction()[2]
                                            .toString(),
                                        value: TransactionDB.instance
                                            .addTotalTransaction()[2],
                                        color: Colors.green.shade400,
                                        radius: 100,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(232, 14, 68, 113),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 5),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.green.shade400,
                                            radius: 8,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Income',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.red.shade400,
                                            radius: 8,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Expense',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_to_photos,
                            size: 50,
                            color: Colors.black12,
                          ),
                          Text(
                            'No Transactions available!',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black38),
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
