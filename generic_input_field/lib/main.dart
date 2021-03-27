import 'package:flutter/material.dart';

import 'input_coin.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String _value;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 300),
            InputCoin(
              placeholderInput: "Quanto voce quer poupar",
              labelWarningMinimum: "valor minimo é de  ",
              labelWarningMaximum: "O valor máximo é de ",
              labelWarningInsuficientBalance: "Informe um valor disponivel em saldo",
              minimumBalance: 20.0,
              maximumBalance: 700.0,
              balanceAccount: 1000.0,
              validatedCoin: (hasValidated, value) {
                print("HasValidated: " + hasValidated.toString());
                print(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
