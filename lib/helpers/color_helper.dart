import 'package:flutter/material.dart';

Color getColor(BuildContext context, double percentage) {
  if (percentage >= 0.5) {
    return Theme.of(context).primaryColor;
  } else if (percentage >= 0.25) {
    return Colors.orange;
  }
    return Colors.red;
}
