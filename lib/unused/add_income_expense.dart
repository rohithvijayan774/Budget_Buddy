import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_management/unused/add_expense.dart';

import 'package:money_management/widgets/add_amount.dart';

class AddIncomeExpense extends StatefulWidget {
  const AddIncomeExpense({super.key});

  @override
  State<AddIncomeExpense> createState() => _AddIncomeExpenseState();
}

class _AddIncomeExpenseState extends State<AddIncomeExpense>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   title: const Text(
      //     'ADD',
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Material(
              color: const Color.fromARGB(255, 14, 69, 113),
              child: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    text: 'INCOME',
                  ),
                  Tab(
                    text: 'EXPENSE',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  Center(
                    child: AddIncome(),
                  ),
                  Center(
                    child: AddExpense(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
