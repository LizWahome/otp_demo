import 'package:flutter/material.dart';
import 'package:kago/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Expanded(
            child: Column(
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
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  'Welcome, sign in with your phone number',
                  style: TextStyle(
                    fontFamily: 'GTWalsheim',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            labelText: 'phone number',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16)),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                  .hasMatch(value)) {
                            return "Enter a valid phone number";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    final isValid = formKey.currentState!.validate();
                    FocusScope.of(context).unfocus();
                    if (isValid) {
                      formKey.currentState!.save();
                      const snackBar = SnackBar(
                        content: Text(
                          'Saved',
                          style: TextStyle(fontSize: 15),
                        ),
                        backgroundColor: Colors.amber,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    sendPhoneNumber();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Verify number',
                      style: TextStyle(
                          fontFamily: 'GTWalsheim',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.logInWithPhone(context, phoneNumber);
  }
}
