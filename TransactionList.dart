import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        child: (transactions.isEmpty)
            ? LayoutBuilder(
                builder: (ctx, constrains) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'there is no transactions yet!!',
                      ),
                      SizedBox(
                        height: 50,
                        width: 250,
                      ),
                      Container(
                        height: constrains.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FittedBox(
                                child: Text(
                                  '\$${transactions[index].amount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transactions[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deletetx(transactions[index].id),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
