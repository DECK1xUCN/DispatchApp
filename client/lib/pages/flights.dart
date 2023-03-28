import 'package:client/pages/notimplemented.dart';
import 'package:client/pages/sidebar.dart';
import 'package:flutter/material.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(width: 300, child: Sidebar()),
          Expanded(child: NotImplemented())
        ],
      ),
    );
  }
}
