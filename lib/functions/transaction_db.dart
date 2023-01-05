import 'package:hive/hive.dart';
import 'package:money_management/model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertTransactions(TransactionModel value);
}

class TransactionDB implements TransactionDbFunction {
  @override
  Future<void> insertTransactions(TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.add(value);
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }
}
