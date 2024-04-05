
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_me/components/list.dart';
import 'package:rent_me/components/validate_btn.dart';
import 'package:rent_me/toast/custom_toast.dart';


class BookingDetails extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const BookingDetails({super.key, required this.documentSnapshot});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  var bookingdays = 0;
  final usercontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: const Image(
                    image: AssetImage('assets/images/logocar.png'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Text(
              'Booking Details',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            ListCars(
              controller: usercontroller,
              text: 'Booked By',
              hinttext: 'please enter your name here',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ListCars(
              controller: addresscontroller,
              text: 'Address',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ListCars(
              controller: phonecontroller,
              text: 'Phone No',
              hinttext: '+92 ***********',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booking Days : ',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        wordSpacing: 1,
                        height: 1,
                        textBaseline: TextBaseline.alphabetic),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueGrey,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (bookingdays == 0) {
                              bookingdays == 0;
                              setState(() {});
                            } else {
                              bookingdays--;
                              setState(() {});
                            }
                          },
                          child: const Center(
                              child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        '$bookingdays',
                        style: const TextStyle(height: 1),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.indigo,
                        ),
                        child: InkWell(
                          onTap: () {
                            bookingdays++;
                            setState(() {});
                          },
                          child: const Center(
                              child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: ValidateBtn(
                title: 'Confirm Book',
                ontap: () {
                  final auth = FirebaseAuth.instance;
                  final firestore =
                      FirebaseFirestore.instance.collection('BookedCars');
                  final carId = widget.documentSnapshot['id'];
                  final qurey = firestore
                      .where('car id', isEqualTo: carId)
                      .where('uid', isEqualTo: auth.currentUser!.uid);
                  qurey.get().then((snapshot) {
                    if (snapshot.docs.isNotEmpty) {
                      CustomToast().Toastt('This Car is Already Booked by you');
                    } else if (usercontroller.text.isEmpty &&
                        addresscontroller.text.isEmpty &&
                        phonecontroller.text.isEmpty) {
                      CustomToast().Toastt('Please Enter your Detail first');
                    } else if (usercontroller.text.isEmpty) {
                      CustomToast().Toastt(
                          'Please enter name of the owner whose booking the car');
                    } else if (addresscontroller.text.isEmpty) {
                      CustomToast().Toastt('Please Enter the adderss');
                    } else if (phonecontroller.text.isEmpty ||
                        phonecontroller.text.length < 11 ||
                        phonecontroller.text.length > 11) {
                      CustomToast().Toastt('Please Enter your phone no');
                    } else if (bookingdays == 0) {
                      CustomToast().Toastt('Please Enter the booking days');
                    } else {
                      String pricestring =
                          widget.documentSnapshot['price'].toString();
                      int price = int.parse(pricestring);
                      int totalprice = bookingdays * price;
                      String bookedID =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      firestore.doc(bookedID).set({
                        'carname': widget.documentSnapshot['make'].toString(),
                        'uid': auth.currentUser!.uid,
                        'image': widget.documentSnapshot['image'].toString(),
                        'model': widget.documentSnapshot['model'].toString(),
                        'price per day':
                            widget.documentSnapshot['price'].toString(),
                        'car id': carId,
                        'totalbill': totalprice.toString(),
                        'bookedId': bookedID,
                        'booked by': usercontroller.text,
                        'address': addresscontroller.text,
                        'phoneno': phonecontroller.text,
                        'booking days': bookingdays.toString(),
                      }).then((value) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Booking Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                //position
                                mainAxisSize: MainAxisSize.min,
                                // wrap content in flutter
                                children: <Widget>[
                                  Text(
                                      "Car Name:      ${widget.documentSnapshot['make']}"),
                                  Text("Booked by :    ${usercontroller.text}"),
                                  Text("Booked days :  $bookingdays"),
                                  Text("Total Bill :   $totalprice"),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.pop(
                                        context); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }).onError((error, stackTrace) {
                        CustomToast().Toastt(error.toString());
                      });
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}