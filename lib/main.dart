import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/screens/splash_screen.dart';

const SAVE_KEY_NAME = 'UserLoggenIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Buddy',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 14, 69, 113)),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
