import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showMessage(BuildContext context, String title, String mssg) {
  Flushbar(
    title: title,
    message: mssg,
    duration: const Duration(seconds: 5),
  ).show(context);
}
