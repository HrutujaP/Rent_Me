import 'package:flutter/material.dart';

class ValidateBtn extends StatelessWidget {
  String title;
  final VoidCallback ontap;
  Color color;
  ValidateBtn({super.key, required this.title, required this.ontap, this.color = const Color(0xff5B6EFB),});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 6,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}