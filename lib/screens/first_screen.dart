import 'package:flutter/material.dart';

import 'package:money_management/widgets/transaction_bar.dart';

import '../widgets/income_expense.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.chevron_left_rounded),
        //   ),
        // ],
        elevation: 0,

        title: const Text(
          '',
          style: TextStyle(fontSize: 25),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/unknown_person_3.png'))
                  // color: Color.fromARGB(255, 14, 69, 113),
                  ),
              child: Text(''),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'App Info',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Reset App',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 17,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 14, 69, 113),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
            ),
            height: 70,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Balance',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '₹ 0.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            width: 370,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 14, 69, 113),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                IncomeExpense(label: 'Income :', amount: '0.00'),
                IncomeExpense(label: 'Expense :', amount: '0.00')
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 395,
            width: 500,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Color.fromARGB(255, 14, 69, 113),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Recent transactions :',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                TransactionBar(
                    date: '28/12/22',
                    type: 'Income',
                    amount: 1000,
                    category: 'Bank'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
