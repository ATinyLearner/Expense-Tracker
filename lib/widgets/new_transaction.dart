import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();

  void _focusNodeChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );
    //This is used to close the current screen!
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              focusNode: _titleFocus,
              autofocus: true,
              textInputAction: TextInputAction.next,
              controller: titleController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) {
                _focusNodeChange(context, _titleFocus, _amountFocus);
              },
            ),
            TextField(
              focusNode: _amountFocus,
              keyboardType: TextInputType.number,
              controller: amountController,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) {
                submitData();
              },
            ),
            FlatButton(
              onPressed: () {
                submitData();
              },
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
