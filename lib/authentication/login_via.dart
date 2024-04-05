
import 'package:flutter/material.dart';
import 'package:rent_me/authentication/login_via_email.dart';
import 'package:rent_me/components/custom_btn.dart';
import 'package:rent_me/phone_no_auth/login_via_phone.dart';

class LoginVia extends StatefulWidget {
  const LoginVia({Key? key}) : super(key: key);

  @override
  State<LoginVia> createState() => _LoginViaState();
}

class _LoginViaState extends State<LoginVia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.height * 0.02,
              ),
              child: SizedBox(
                height: 300,
                width: 450,
                child: Hero(
                  tag: 'background',
                  child: Image(
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.height * 0.60,
                      width: MediaQuery.of(context).size.height * 0.40,
                      image: const AssetImage('assets/images/logocar.png')),
                ),
              ),
            ),
            const Text('Car Rental App',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff282F66))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: CustomBtn(
                icon: const Icon(Icons.arrow_circle_right_rounded),
                title: 'Login via Email',
                ontap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginViaEmail(),
                      ));
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02,
              ),
              child: CustomBtn(
                icon: const Icon(Icons.arrow_circle_right_rounded),
                title: 'Login via PhoneNo',
                ontap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginViaPhone(),
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