import 'package:flutter/material.dart';
import 'package:kago/provider/auth_provider.dart';
import 'package:kago/utilis/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class otpScreen extends StatefulWidget {
  final String verificationId;
  const otpScreen({super.key, required this.verificationId});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Expanded(
            child: isLoading == true
                ? const CircularProgressIndicator(
                    color: Colors.amber,
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: RichText(
                          text: const TextSpan(
                              text: 'Ka',
                              style: TextStyle(
                                  fontFamily: 'stereofunk',
                                  fontSize: 40,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 'go',
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontFamily: 'stereofunk',
                                      fontSize: 40,
                                    ))
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        'Enter the six digit code sent to you',
                        style: TextStyle(
                          fontFamily: 'GTWalsheim',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'GTWalsheim',
                              fontWeight: FontWeight.bold,
                            )),
                        onSubmitted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                    width: 1.5, style: BorderStyle.solid))),
                        onPressed: () {
                          if (otpCode != null) {
                            verifyOtp(context, otpCode!);
                          } else {
                            showSnackBar(context, "Enter 6-Digit code");
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontFamily: 'GTWalsheim',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {});
  }
}
