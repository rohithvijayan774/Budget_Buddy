import 'package:flutter/cupertino.dart';

class TransactionBarProvider with ChangeNotifier {
  DateTime date = DateTime.now();
  String type = '';
  double amount = 0;
  String category = '';

  
}
