import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/name_screen.dart';
import 'package:money_management/screens/splash_screen.dart';

const SAVE_KEY_NAME = 'UserLoggenIn';
Future<void> main() async {
  final obj1 = TransactionDB();
  final obj2 = TransactionDB();
  print('objects comparing');
  print(obj1 == obj2);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Money',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 14, 69, 113)),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
