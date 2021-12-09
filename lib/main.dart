import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  // initializes the app
  // WidgetsFlutterBinding.ensureInitialized();

  // Disable landscape mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Platform.isIOS
    //     ? CupertinoApp(
    //         title: 'Flutter App',
    //         home: MyHomePage(),
    //       )
    //     :
    return MaterialApp(
      title: 'Flutter App',
      // theme: ThemeData(
      //     primaryColor: Colors.blueGrey[600],
      //     secondaryHeaderColor: Colors.yellow[700],
      //     scaffoldBackgroundColor: Colors.blueGrey[700],
      //     cardColor: Colors.blueGrey[600],
      //     backgroundColor: Colors.blueGrey,
      //     dialogBackgroundColor: Colors.blueGrey,
      //     colorScheme: ColorScheme.dark().copyWith(
      //       primary: Colors.blueGrey[800],
      //       onPrimary: Colors.yellow,
      //       secondary: Colors.yellow[700],
      //       onBackground: Colors.blueGrey[700],
      //       background: Colors.blueGrey[700],
      //       surface: Colors.blueGrey[600],
      //       // primaryVariant: Colors.yellow[700],
      //     ),
      //     dialogTheme: DialogTheme(
      //       backgroundColor: Colors.blueGrey[600],
      //       titleTextStyle: TextStyle(
      //         color: Colors.yellow[700],
      //       ),
      //     ),
      //     fontFamily: "OpenSans",
      //     textTheme: TextTheme(
      //       bodyText1: TextStyle(color: Colors.white),
      //       bodyText2: TextStyle(color: Colors.white),
      //       headline6: TextStyle(
      //         fontFamily: "Cascadia",
      //         fontSize: 18,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     buttonTheme: ButtonThemeData(
      //       buttonColor: Colors.yellow[700],
      //       textTheme: ButtonTextTheme.normal,
      //     ),
      //     textButtonTheme: TextButtonThemeData(
      //       style: ButtonStyle(
      //         foregroundColor: MaterialStateProperty.all(Colors.yellow[700]),
      //       ),
      //     ),
      //     elevatedButtonTheme: ElevatedButtonThemeData(
      //       style: ButtonStyle(
      //         backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
      //         foregroundColor: MaterialStateProperty.all(Colors.white),
      //       ),
      //     ),
      //     appBarTheme: AppBarTheme(
      //       backgroundColor: Colors.blueGrey[600],
      //       titleTextStyle: TextStyle(
      //         fontFamily: "Cascadia",
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

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

  void _addNewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _delTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          child: GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransactions),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScaped = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Flutter Expense App'),
            actions: [
              IconButton(
                onPressed: () {
                  _startAddNewTransaction(context);
                },
                icon: Icon(Icons.add_box_sharp),
              )
            ],
          ) as PreferredSizeWidget;

    final Widget txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: TransactionList(
        _transactions,
        _delTransaction,
      ),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandScaped)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (bool value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (isLandScaped)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.8,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
            if (!isLandScaped)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandScaped) txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                onPressed: () => {_startAddNewTransaction(context)},
                child: Icon(Icons.add),
                backgroundColor: Theme.of(context).secondaryHeaderColor),
            // color: Theme.of(context).,
          );
  }
}
