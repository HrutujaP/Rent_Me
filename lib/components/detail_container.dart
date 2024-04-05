import 'package:flutter/material.dart';

class DetailContainer extends StatelessWidget {
  var image;
  String text;
  String title, subtitle;
  VoidCallback? ontap;

  DetailContainer({super.key,
    required this.image,
    required this.text,
    required this.title,
    required this.subtitle,
    this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.14,
          width: MediaQuery
              .of(context)
              .size
              .height * 0.80,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8FD),
              borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(image),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.35,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(subtitle),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}