import 'package:flutter/material.dart';
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
      ),
      body: Center(
        child: DatePicker(),
      ),
    );
  }
}
