import 'package:flutter/material.dart';

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void goTo(
    {required BuildContext context, required String view, bool? replace}) {
  replace != null && replace
      ? Navigator.pushReplacementNamed(context, view)
      : Navigator.pushNamed(context, view);
}

void push(
    {required BuildContext context, required Widget view, bool? replace}) {
  replace != null && replace
      ? Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => view))
      : Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
