import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _dateTimeFocus = FocusNode();

  void _focusNodeChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    //This is used to close the current screen!
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
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
                textInputAction: TextInputAction.next,
                controller: amountController,
                cursorColor: Theme.of(context).accentColor,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                onSubmitted: (_) {
                  _focusNodeChange(context, _amountFocus, _dateTimeFocus);
                  _displayDatePicker();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Date'
                            : DateFormat.yMd().format(_selectedDate),
                      ),
                    ),
                    FlatButton(
                      focusNode: _dateTimeFocus,
                      textColor: Theme.of(context).accentColor,
                      onPressed: _displayDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _submitData();
                },
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
