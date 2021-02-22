import 'package:flutter/material.dart';
import 'package:quotes_generator/theme/styles.dart';

class ErrorLabel extends StatelessWidget {
  final String msg;

  const ErrorLabel({this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            msg,
            style: errorTextStyle(),
            textAlign: TextAlign.center,
          ),
        ));
  }


}
