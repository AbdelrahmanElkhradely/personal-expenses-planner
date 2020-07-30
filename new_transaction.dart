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
  DateTime selecteddate;

  void showdatewin() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        selecteddate = pickeddate;
      });
    });
  }

  void submitdata() {
    final eneteredtitle = titleController.text;
    final enteredamount = double.parse(amountController.text);

    if (eneteredtitle.isEmpty || enteredamount <= 0 || selecteddate == null) {
      return;
    }
    widget.addTx(eneteredtitle, enteredamount, selecteddate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 15,
              right: 10,
              top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onChanged: (val) {
                //   titleInput = val;
                // },
                onSubmitted: (_) => submitdata(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                // onChanged: (val) => amountInput = val,
                onSubmitted: (_) => submitdata(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Text(selecteddate == null
                        ? 'no date is chosen'
                        : DateFormat.yMd().format(selecteddate)),
                    FlatButton(
                        onPressed: showdatewin,
                        child: Text(
                          'choose the date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.amber,
                textColor: Colors.white,
                onPressed: submitdata,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
