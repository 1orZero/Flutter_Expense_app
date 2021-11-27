import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
import './user_transactions.dart';

class TransactionList extends StatefulWidget {
  @override
  _transactionListState createState() => _transactionListState();
}

class _transactionListState extends State<TransactionList> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().add(Duration(hours: 10)),
    ),
    Transaction(
      id: 't3',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().add(Duration(hours: -10)),
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransactions),
        UserTransactions(
          _transactions,
        ),
      ],
    );
  }
}
