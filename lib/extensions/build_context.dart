import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBar({required Widget content}) {
    final snackBar = SnackBar(
      content: content,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
