import 'package:hive_flutter/adapters.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String? notes;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.notes,
  });
  @override
  String toString() {
    return '{$id $amount $date $category $type}';
  }
}
