import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense app'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: Colors.blue,
            margin: EdgeInsets.all(20),
            child: Container(
              child: Text(
                'Chart !',
                textAlign: TextAlign.center,
              ),
              width: double.infinity,
              height: 50,
            ),
            elevation: 5,
          ),
          Card(
            child: Text('LIST OF TX'),
          ),
        ],
      ),
    );
  }
}
