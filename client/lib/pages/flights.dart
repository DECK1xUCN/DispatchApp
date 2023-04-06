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
            height: 50,
            decoration: const BoxDecoration(

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    DateFormat.Hm().format(element.etd),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.flightnumber,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.from,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.via.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.to,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Flights',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
                ),
                child: const Text('New Flight'),
                onPressed: () {

                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: Colors.white),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'ETD',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Flight number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'From',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Via',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'To',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...generateRows(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}