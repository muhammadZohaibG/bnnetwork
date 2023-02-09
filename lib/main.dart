import 'package:b_networks/views/splash_screen.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/views/city_details/provider/city_detail_provider.dart';
import 'package:b_networks/views/expense/provider/expenses_provider.dart';
import 'package:b_networks/views/home/provider/home_provider.dart';
import 'package:b_networks/views/login/provider/login_provider.dart';
import 'package:b_networks/views/monthly_bill/provider/monthly_bill_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/*
Provider(
  create: (context) {
    return Model(Provider.of<Something>(context, listen: false)),
  },
)
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ExpensesProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => CityDetailProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => MonthlyBillProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => LoginProvider(), lazy: false)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'B - Networks App',
        theme: ThemeData(
            //primarySwatch:primaryColor //Colors.blue,
            primaryColor: primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
