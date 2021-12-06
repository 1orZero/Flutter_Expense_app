import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (titleInput.text.isEmpty || amountInput.text.isEmpty) {
      return;
    }
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    final enteredDate = _selectedDate;

    widget.addTx(enteredTitle, enteredAmount, enteredDate);
    print('Button clicked');

    Navigator.of(context).pop();
    print('Navigator clicked');
  }

  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) => {
          if (pickedDate != null)
            {
              setState(() {
                _selectedDate = pickedDate;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleInput,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: amountInput,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Text(
                      'Date: ${DateFormat.yMMMMd('en_US').format(_selectedDate)}'),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        // color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDataPicker,
                  ),
                ]),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
