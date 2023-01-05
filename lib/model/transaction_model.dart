import 'package:hive_flutter/adapters.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String incomeAmount;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String note;

  TransactionModel(
      {required this.id,
      required this.incomeAmount,
      required this.date,
      required this.category,
      required this.note});
  @override
  String toString() {
    return '{$incomeAmount $date}';
  }
}
