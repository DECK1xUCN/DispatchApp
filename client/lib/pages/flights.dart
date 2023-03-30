import 'package:client/classes/Flight.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  List<Flight> flights = [
    Flight(
        etd: DateTime.now().add(const Duration(hours: 1)),
        flightnumber: 'ABC-1',
        from: 'A',
        via: ['B', 'C'],
        to: 'D'),
    Flight(
        etd: DateTime.now().add(const Duration(hours: 2)),
        flightnumber: 'ABC-2',
        from: 'A',
        via: ['B', 'C'],
        to: 'D'),
    Flight(
        etd: DateTime.now().add(const Duration(hours: 3)),
        flightnumber: 'ABC-3',
        from: 'A',
        via: ['B', 'C'],
        to: 'D'),
    Flight(
        etd: DateTime.now().add(const Duration(hours: 4)),
        flightnumber: 'ABC-4',
        from: 'A',
        via: ['B', 'C'],
        to: 'D'),
  ];

  List<Widget> generateRows() {
    List<Widget> rows = [];
    for (var element in flights) {
      rows.add(GestureDetector(
        onTap: () {
          print('tapped' + element.flightnumber.toString());
        },
        child: Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                        child: Text(DateFormat.Hm().format(element.etd))),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text(element.flightnumber)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text(element.from)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text(element.via.toString())),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text(element.to)),
                  ),
                ),
              ],
            )),
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(children: <Widget>[
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          child: const Center(
                              child: Text(
                            'ETD',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: const Center(
                              child: Text(
                            'Flight number',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: const Center(
                              child: Text(
                            'From',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: const Center(
                              child: Text(
                            'Via',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: const Center(
                              child: Text(
                            'To',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                ...generateRows()
              ]),
            ),
            const Text('space for generating dfr button')
          ],
        ),
      ),
    );
  }
}
