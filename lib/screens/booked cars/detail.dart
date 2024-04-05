import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_me/components/custom_detail_booking.dart';


class Detail extends StatefulWidget {
  final DocumentSnapshot documentsnapshot;

  const Detail({super.key, required this.documentsnapshot});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Booking Detail',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.car_rental),
              ),
              title: const Text(
                'Booked By',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['booked by'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.car_crash_rounded),
              ),
              title: const Text(
                'Car Name',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['carname'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.phone),
              ),
              title: const Text(
                'Phone No',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['phoneno'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.car_rental),
              ),
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['address'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.car_rental),
              ),
              title: const Text(
                'Booking Days',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['booking days'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          CustomBooking(
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.car_rental),
              ),
              title: const Text(
                'Total Bill',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.documentsnapshot['totalbill'],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                'Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}