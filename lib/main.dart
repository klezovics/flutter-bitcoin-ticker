import 'package:flutter/material.dart';

import 'price_screen.dart';

void main() => runApp(MyApp());

//316ADCD-64CD-4F33-A018-6E6AB8B435B6
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
