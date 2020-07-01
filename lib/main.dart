import 'package:flutter/material.dart';
import 'package:my_first_app/CurrencyList.dart';
import 'CurrencyList.dart';

void main() => runApp(CurrencyTracker());

class CurrencyTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currencies',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CurrencyList());
  }
}
