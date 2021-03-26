import 'package:flutter/material.dart';
import 'package:generic_input_field/pb_input.dart';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: PBInput(
                labelInputText: "Test",
                obscureText: false,
                suffixIcon: "assets/images/ic_input_text_coin.png",
                onKeyPressed: (contract, value) {
                  contract.setLabelStyle(Colors.red, 18.0, FontWeight.normal, .0);
                  if (value.isNotEmpty) {
                    contract.setLabelStyle(null, null, null, 0);
                    contract.setError(
                        "Error Message",
                        "pathIconError",
                        true,
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: const Color(0xffb00020),
                          width: 5.0,
                        )),
                        Colors.black,
                        14.0,
                        FontWeight.normal);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
