
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rent_me/components/detail_container.dart';
import 'package:rent_me/screens/admin%20car%20list/admin_car_detail.dart';
import 'package:rent_me/toast/custom_toast.dart';

class AdminCarList extends StatefulWidget {
  const AdminCarList({super.key});

  @override
  State<AdminCarList> createState() => _AdminCarListState();
}

class _AdminCarListState extends State<AdminCarList> {
  final searchcontroller = TextEditingController();
  String search = '';
  CollectionReference ref = FirebaseFirestore.instance.collection('Cars');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 25,
                          weight: 5.0,
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Card(
                borderOnForeground: true,
                elevation: 1,
                child: TextFormField(
                  controller: searchcontroller,
                  cursorColor: Colors.black38,
                  decoration: const InputDecoration(
                      focusColor: Colors.black38,
                      hintText: 'Search',
                      hintStyle: TextStyle(letterSpacing: 1.6),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        size: 30,
                        color: Colors.black38,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38))),
                  onChanged: (value) {
                    search = value.toString();
                    setState(() {});
                  },
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Admin Cars',
                  style: TextStyle(
                      letterSpacing: 1.5, color: Colors.black38, fontSize: 19),
                ),
                Icon(Icons.tornado_outlined, color: Colors.black38)
              ],
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Cars").snapshots(),
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
                        String carname =
                            snapshot.data!.docs[index]['make'].toString();
                        String id = snapshot.data!.docs[index]['id'].toString();
                        if (searchcontroller.text.isEmpty) {
                          return Slidable(
                            startActionPane:
                                ActionPane(motion: const BehindMotion(), children: [
                              SlidableAction(
                                onPressed: (context) {
                                  ref.doc(id).delete().then((value) {
                                    CustomToast()
                                        .Toastt('Vehicle Deleted Successfully');
                                  }).onError((error, stackTrace) {
                                    CustomToast().Toastt(error.toString());
                                  });
                                },
                                label: 'Delete',
                                backgroundColor: Colors.indigo,
                                autoClose: true,
                                foregroundColor: Colors.black,
                                flex: 2,
                                icon: Icons.delete,
                                spacing: 2.0,
                              )
                            ]),
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: DetailContainer(
                                image: documentsnapshot['image'].toString(),
                                text:
                                    '${documentsnapshot['price'].toString()}/day',
                                title: documentsnapshot['make'].toString(),
                                subtitle:
                                    documentsnapshot['category'].toString(),
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminCarDetail(
                                          documentSnapshot: documentsnapshot,
                                        ),
                                      ));
                                },
                              ),
                            ),
                          );
                        } else if (carname
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase())) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: DetailContainer(
                              image: snapshot.data!.docs[index]['image']
                                  .toString(),
                              text:
                                  '${documentsnapshot['price'].toString()}/day',
                              title:
                                  snapshot.data!.docs[index]['make'].toString(),
                              subtitle: snapshot.data!.docs[index]['category']
                                  .toString(),
                              ontap: () {},
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}