import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  var text;

  CustomNavBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
              child: Text(
            'Rs ${text}/day',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )),
          Container(
            height: 70,
            width: 220,
            decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(20))),
            child: const Center(
              child: Text(
                'Book now',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }
}