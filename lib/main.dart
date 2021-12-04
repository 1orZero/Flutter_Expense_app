import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primaryColor: Colors.blueGrey[600],
          secondaryHeaderColor: Colors.yellow[700],
          scaffoldBackgroundColor: Colors.blueGrey[700],
          cardColor: Colors.blueGrey[600],
          backgroundColor: Colors.blueGrey,
          dialogBackgroundColor: Colors.blueGrey,
          colorScheme: ColorScheme.dark(),
          fontFamily: "OpenSans",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            headline6: TextStyle(
              fontFamily: "Cascadia",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[600],
            titleTextStyle: TextStyle(
              fontFamily: "Cascadia",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now().add(Duration(hours: -10)),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransactions(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        id: DateTime.now().toString(),
        date: DateTime.now());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransactions),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense App'),
        actions: [
          IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add_box_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(
              _transactions,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => {_startAddNewTransaction(context)},
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).secondaryHeaderColor),
      // color: Theme.of(context).,
    );
  }
}
