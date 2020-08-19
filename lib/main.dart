import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';

void main() {
  //**This are used to lock app in portrait mode
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//    [
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
//    ],
//  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline1: GoogleFonts.lobster(fontSize: 30),
          bodyText2: GoogleFonts.merriweatherSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        primaryColor: Color(0xff2749D8),
        accentColor: Color(0xff526DE0),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  void _addTransaction(String title, double amount, DateTime pickedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      date: pickedDate,
      title: title,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    //tx represents transaction
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
      ],
      centerTitle: true,
      title: Text(
        'Expense Tracker',
        style: Theme.of(context).primaryTextTheme.headline1,
      ),
    );
    return Scaffold(
      appBar: statusBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: [
                Text('Show Chart'),
                Switch(value: null, onChanged: () {}),
              ],
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      statusBar.preferredSize.height) *
                  .3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      statusBar.preferredSize.height) *
                  .7,
              child: TransactionList(
                _userTransactions,
                _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
