import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  AdaptiveButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              label,
              style: TextStyle(
                // color: Theme.of(context).secondaryHeaderColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.all(2),
            onPressed: onPressed)
        // onPressed: _presentDataPicker)
        : TextButton(
            child: Text(
              label,
              style: TextStyle(
                // color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: onPressed,
          );
  }
}
