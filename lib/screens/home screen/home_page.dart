
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_me/authentication/login_via.dart';
import 'package:rent_me/components/custom_list_tile.dart';
import 'package:rent_me/components/detail_container.dart';
import 'package:rent_me/screens/admin_panel_auth.dart';
import 'package:rent_me/screens/booked%20cars/booked_car_user.dart';
import 'package:rent_me/screens/car_detail.dart';
import 'package:rent_me/screens/user_detail.dart';
import 'package:rent_me/toast/custom_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  final searchcontroller = TextEditingController();
  String search = '';
  String carname = '';
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.29,
                  width: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    color: const Color(0xff282F66),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.indigo,
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/logocar.png'),
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .where("uid", isEqualTo: auth.currentUser!.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        snapshot.data!.docs[index]['username']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        snapshot.data!.docs[index]['email']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: const Text(
                    'Category',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomListtile(
                  icon: const Icon(Icons.home_filled),
                  title: 'Home Page',
                  ontap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false);
                    _globalKey.currentState!.closeDrawer();
                  },
                ),
                CustomListtile(
                  icon: const Icon(Icons.car_rental),
                  title: 'Booked Car',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookedCarUser(),
                        ));
                  },
                ),
                CustomListtile(
                  icon: const Icon(Icons.admin_panel_settings_outlined),
                  title: 'Admin Panel',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPanelAuth(),
                        ));
                  },
                ),
                CustomListtile(
                  icon: const Icon(Icons.details_outlined),
                  title: 'User Detail',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserDetail(),
                        ));
                    _globalKey.currentState!.closeDrawer();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: IconButton(
                      onPressed: () {
                        auth.signOut().then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginVia(),
                              ),
                              (route) => false);
                          CustomToast().Toastt('LogOut');
                        }).onError((error, stackTrace) {
                          CustomToast().Toastt(error.toString());
                        });
                      },
                      icon: const Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {
                            _globalKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            size: 34,
                            weight: 5.0,
                          )),
                    ),
                  ),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BookedCarUser(),
                                ));
                          },
                          icon: const Icon(
                            Icons.car_rental_outlined,
                            size: 34,
                            weight: 5.0,
                          )),
                    ),
                  )
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
                    'All Cars',
                    style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.black38,
                        fontSize: 19),
                  ),
                  Icon(Icons.tornado_outlined, color: Colors.black38)
                ],
              ),
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Cars").snapshots(),
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
                          carname =
                              snapshot.data!.docs[index]['make'].toString();
                          if (searchcontroller.text.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: DetailContainer(
                                image: snapshot.data!.docs[index]['image']
                                    .toString(),
                                text:
                                    '${snapshot.data!.docs[index]['price'].toString()}/day',
                                title: snapshot.data!.docs[index]['make']
                                    .toString(),
                                subtitle: snapshot.data!.docs[index]['category']
                                    .toString(),
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarDetail(
                                          documentSnapshot: documentsnapshot,
                                        ),
                                      ));
                                },
                              ),
                            );
                          } else if (carname
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase())) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: DetailContainer(
                                image: snapshot.data!.docs[index]['image']
                                    .toString(),
                                text: snapshot.data!.docs[index]['price']
                                    .toString(),
                                title: snapshot.data!.docs[index]['make']
                                    .toString(),
                                subtitle: snapshot.data!.docs[index]['category']
                                    .toString(),
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
        ));
  }
}