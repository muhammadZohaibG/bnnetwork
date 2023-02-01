import 'package:b_networks/splash_screen.dart';
import 'package:b_networks/views/CityDetailPage/provider/city_detail_provider.dart';
import 'package:b_networks/views/ExpensesPage/provider/expenses_provider.dart';
import 'package:b_networks/views/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ExpensesProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (context) => CityDetailProvider(), lazy: false)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'B - Networks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
