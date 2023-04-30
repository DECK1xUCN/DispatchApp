import 'package:flutter/material.dart';

class NotImplemented extends StatelessWidget {
  const NotImplemented({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: Text('This page is not implemented yet!',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    ),
    ),
    );
  }
}
