import 'package:flutter/cupertino.dart';
import 'package:money_management/model/transaction_model.dart';

class TransactionBarProvider with ChangeNotifier {
  DateTime? date;
  String? type;
  double? amount;
  String? category;

  // TransactionBarProvider({
  //   required this.date,
  //   required this.type,
  //   required this.amount,
  //   required this.category,
  // });
}
