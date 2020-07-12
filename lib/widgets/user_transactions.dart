import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      amount: 451.2312,
      date: DateTime.now(),
      title: 'New Shoe',
    ),
    Transaction(
      id: 't2',
      amount: 145.154,
      date: DateTime.now(),
      title: 'Weekly Grocery',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(),
        TransactionList(_userTransactions),
      ],
    );
  }
}
