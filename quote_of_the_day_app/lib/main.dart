import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quote of the day app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          appBarTheme: AppBarTheme(backgroundColor: Colors.amber[200]),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
