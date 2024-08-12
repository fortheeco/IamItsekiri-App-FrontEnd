import 'package:flutter/material.dart';

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void goTo({
  required BuildContext context,
  required String view,
}) {
  Navigator.pushNamed(context, view);
}
