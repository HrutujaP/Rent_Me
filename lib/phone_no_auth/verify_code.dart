
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rent_me/components/validate_btn.dart';
import 'package:rent_me/phone_no_auth/login_via_phone.dart';
import 'package:rent_me/toast/custom_toast.dart';
import 'package:rent_me/user%20profile/user_data.dart';



class VerifyCode extends StatefulWidget {
  String number;
  final verifactionid;

  VerifyCode({super.key, required this.number, required this.verifactionid});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final verifyController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginViaPhone(),
                          ));
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 37,
                      semanticLabel: 'Back',
                      shadows: [
                        Shadow(
                            color: Colors.white10,
                            blurRadius: 15.0,
                            offset: Offset(2.0, 4.0))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.height * 0.40,
                child: const Icon(
                  Icons.lock,
                  size: 105,
                  color: Colors.indigo,
                  shadows: [
                    Shadow(
                        color: Colors.white10,
                        blurRadius: 15.0,
                        offset: Offset(2.0, 4.0))
                  ],
                )),
            const Text(
              'OTP Verification',
              style: TextStyle(
                  color: Color(0xff282F66),
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Enter the OTP send to :",
                    style: TextStyle(
                        color: Colors.indigo.withOpacity(0.6), fontSize: 15),
                    children: [
                      TextSpan(
                          text: '  ${widget.number}',
                          style: const TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold))
                    ])),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.04),
              child: Pinput(
                controller: verifyController,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(30, 60, 87, 1),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.indigo, width: 2.0),
                  ),
                ),
                length: 6,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.06),
              child: ValidateBtn(
                title: 'Verify',
                ontap: () async {
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verifactionid,
                      smsCode: verifyController.text.toString());
                  await auth.signInWithCredential(credential).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const userdata(),
                        ),
                        (route) => false);
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