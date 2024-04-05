
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_me/components/detail_container.dart';
import 'package:rent_me/screens/admin/admin_panel.dart';

import 'Detail.dart';

class AllUserBookedCars extends StatefulWidget {
  const AllUserBookedCars({super.key});

  @override
  State<AllUserBookedCars> createState() => _AllUserBookedCarsState();
}

class _AllUserBookedCarsState extends State<AllUserBookedCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Card(
                  elevation: 3,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminPanel(),
                            ),
                            (route) => false);
                      },
                      icon: const Icon(
                        Icons.navigate_before_outlined,
                        size: 34,
                        weight: 5.0,
                      )),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  'All Booked Cars',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('BookedCars').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentsnapshot =
                          snapshot.data!.docs[index];
                      return DetailContainer(
                        image: snapshot.data!.docs[index]['image'],
                        text: snapshot.data!.docs[index]['totalbill'],
                        title: snapshot.data!.docs[index]['carname'],
                        subtitle: snapshot.data!.docs[index]['booked by'],
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  documentsnapshot: documentsnapshot,
                                ),
                              ));
                        },
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}