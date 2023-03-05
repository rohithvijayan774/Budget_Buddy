import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/functions/transaction_db.dart';
import 'package:money_management/model/transaction_model.dart';
import 'package:money_management/providers/add_money_provider.dart';
import 'package:money_management/providers/first_screen_provider.dart';
import 'package:money_management/providers/home_screen_provider.dart';
import 'package:money_management/providers/name_screen_provider.dart';
import 'package:money_management/providers/search_traanaction_provider.dart';
import 'package:money_management/providers/statistics_screen_provider.dart';
import 'package:money_management/providers/transaction_bar_provider.dart';
import 'package:money_management/providers/transaction_screen_provider.dart';
import 'package:money_management/providers/user_name_bar_provider.dart';
import 'package:money_management/screens/splash_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddMoneyProvider>(
          create: (_) => AddMoneyProvider(),
        ),
        ChangeNotifierProvider<TransactionBarProvider>(
          create: (_) => TransactionBarProvider(),
        ),
        ChangeNotifierProvider<UserNameBarProvider>(
          create: (_) => UserNameBarProvider(),
        ),
        ChangeNotifierProvider<NameScreenProvider>(
          create: (_) => NameScreenProvider(),
        ),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (_) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider<SearchTransactionsProvider>(
          create: (_) => SearchTransactionsProvider(),
        ),
        ChangeNotifierProvider<StatisticsScreenProvider>(
          create: (_) => StatisticsScreenProvider(),
        ),
        ChangeNotifierProvider<TransactionScreenProvider>(
          create: (_) => TransactionScreenProvider(),
        ),
        ChangeNotifierProvider<FirtScreenProvider>(
          create: (_) => FirtScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget Buddy',
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 14, 69, 113)),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
