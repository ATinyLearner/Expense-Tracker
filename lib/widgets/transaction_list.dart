import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'It is empty.',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'images/box.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Add some Transaction!',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '\u20B9 ${transactions[index].amount.toStringAsFixed(2)}',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 2,
                          color: Theme.of(context).accentColor,
                        )),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).primaryTextTheme.bodyText2,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
