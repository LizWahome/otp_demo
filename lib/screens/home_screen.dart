import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Home",
          style: TextStyle(
              fontFamily: 'GTWalsheim',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}
