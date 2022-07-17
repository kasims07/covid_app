import 'package:covid_app/screens/country_list.dart';
import 'package:covid_app/screens/detail_screen.dart';
import 'package:covid_app/screens/splash_screen.dart';
import 'package:covid_app/screens/world_states.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue
      ),
      home: const SplashScreen(),
      routes: {

        WorldState.routName: (context) => const WorldState(),
        CountryList.routName: (context) => const CountryList(),
      },
    );
  }
}

