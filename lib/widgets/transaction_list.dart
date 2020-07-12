import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  '\u20B9 ${tx.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                  color: Colors.blue,
                )),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tx.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(tx.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
