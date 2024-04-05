import 'package:flutter/material.dart';
import 'package:rent_me/components/custom_btn.dart';
import 'package:rent_me/screens/add%20cars/add_cars.dart';
import 'package:rent_me/screens/admin%20car%20list/car_list_admin.dart';
import 'package:rent_me/screens/booked%20cars/all_users_booked_cars.dart';
import 'package:rent_me/screens/home%20screen/home_page.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
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
                                builder: (context) => const HomePage(),
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
                    'Admin Panel',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Icon(
              Icons.admin_panel_settings,
              size: 200,
              color: Color(0xff282F66),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('What do you want to do',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              child: CustomBtn(
                color: Colors.white70,
                icon: const Icon(
                  Icons.car_crash_outlined,
                  size: 40,
                ),
                title: 'Add Cars',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCars(),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: CustomBtn(
                color: Colors.blueGrey.shade200,
                icon: const Icon(
                  Icons.car_repair,
                  size: 40,
                ),
                title: 'Cars List',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminCarList(),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: CustomBtn(
                color: Colors.white70,
                icon: const Icon(
                  Icons.car_rental,
                  size: 40,
                ),
                title: 'Booked Cars',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllUserBookedCars(),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}