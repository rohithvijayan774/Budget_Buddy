import 'package:flutter/material.dart';
import 'package:money_management/screens/search_transactions.dart';
import 'package:money_management/widgets/date_picker.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('STATISTICS'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchTransactions()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}
