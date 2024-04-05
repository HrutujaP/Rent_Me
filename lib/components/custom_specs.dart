import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSpecs extends StatelessWidget {
  String text;
  Icon icon;

  CustomSpecs({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigo.shade400,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            icon,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0,color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}