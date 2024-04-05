
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_me/components/list.dart';
import 'package:rent_me/components/validate_btn.dart';
import 'package:rent_me/toast/custom_toast.dart';

class AdminCarDetail extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const AdminCarDetail({super.key, required this.documentSnapshot});

  @override
  State<AdminCarDetail> createState() => _AdminCarDetailState();
}

class _AdminCarDetailState extends State<AdminCarDetail> {
  var categorycontroller = TextEditingController();
  var makecontroller = TextEditingController();
  var modelcontroller = TextEditingController();
  var modelyearcontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var fuelcontroller = TextEditingController();
  var transmissioncontroller = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('Cars');

  @override
  Widget build(BuildContext context) {
    categorycontroller.text = widget.documentSnapshot['category'];
    makecontroller.text = widget.documentSnapshot['make'];
    modelcontroller.text = widget.documentSnapshot['model'];
    modelyearcontroller.text = widget.documentSnapshot['modelyear'];
    pricecontroller.text = widget.documentSnapshot['price'];
    fuelcontroller.text = widget.documentSnapshot['fuel'];
    transmissioncontroller.text = widget.documentSnapshot['transmission'];
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
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: ClipRRect(
                child: Image(
                  image: NetworkImage(widget.documentSnapshot['image']),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: const Row(
                children: [
                  Text(
                    'Car Detail',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, height: 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ListCars(
                text: 'Vehicle',
                hinttext: 'cars,jeep,bike',
                controller: categorycontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Make',
                hinttext: 'Car Brand',
                controller: makecontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Model',
                hinttext: 'Car Model',
                controller: modelcontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Model Year',
                hinttext: 'Car Model year',
                controller: modelyearcontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Price per day',
                hinttext: 'Price',
                controller: pricecontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Fuel',
                hinttext: 'Petrol,desial,gas',
                controller: fuelcontroller),
            const SizedBox(
              height: 20,
            ),
            ListCars(
                text: 'Transmission',
                hinttext: 'Automatic,Manual',
                controller: transmissioncontroller),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: ValidateBtn(
                title: 'Update Data',
                ontap: () {
                  String id = widget.documentSnapshot['id'].toString();
                  ref.doc(id).update({
                    'category': categorycontroller.text,
                    'fuel': fuelcontroller.text,
                    'make': makecontroller.text,
                    'model': modelcontroller.text,
                    'modelyear': modelyearcontroller.text,
                    'price': pricecontroller.text.toString(),
                    'transmission': transmissioncontroller.text
                  }).then((value) {
                    CustomToast().Toastt('Data Updated Succsessfully');
                  }).onError((error, stackTrace) {
                    CustomToast().Toastt(error.toString());
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