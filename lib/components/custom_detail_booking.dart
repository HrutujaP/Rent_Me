import 'package:flutter/material.dart';

class CustomBooking extends StatelessWidget {
  Widget leading;
  Widget title;
  Widget subtitle;

  CustomBooking(
      {super.key,
      required this.leading,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
    );
  }
}