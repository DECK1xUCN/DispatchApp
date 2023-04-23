import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../classes/Dfr.dart';

class DFRsWithId extends StatefulWidget {
  const DFRsWithId({Key? key}) : super(key: key);

  @override
  _DFRsWithIdState createState() => _DFRsWithIdState();
}

class _DFRsWithIdState extends State<DFRsWithId> {
  List<Dfr> dfrs = [
    Dfr(
      id: 123,
      model: 'EC 145',
      registration: 'D-HTMK',
      date: DateTime(2023, 1, 14),
      pilot: 'SRO',
      hoistOperator: 'BRA',
      dailyUpdate: true,
    ),
    Dfr(
      id: 124,
      model: 'EC 145',
      registration: 'D-HTMK',
      date: DateTime.now(),
      pilot: 'SRO',
      hoistOperator: 'BRA',
      dailyUpdate: true,
    ),
  ];

  List<Widget> generateRows() {
    List<Widget> rows = [];
    for (var element in dfrs) {
      rows.add(GestureDetector(
        onTap: () {
          //do something
        },
        child: Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    element.id.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.model,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.registration,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    DateFormat.yMd().format(element.date),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.pilot,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.hoistOperator,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.dailyUpdate.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.id.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.id.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    element.id.toString(),
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
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
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
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: Color.fromRGBO(211, 211, 211, 1)),
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromRGBO(211, 211, 211, 1)),
                  ),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('A/C Model EC 145',
                                      style: TextStyle(fontSize: 16)),
                                  Text('A/C Registration D-HTMK',
                                      style: TextStyle(fontSize: 16)),
                                  Text('Date 14.01.2023',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Pilot SRO',
                                      style: TextStyle(fontSize: 16)),
                                  Text('Hoist Operator BRA',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Container(
                alignment: Alignment.topRight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
                  ),
                  child: const Text('New Report'),
                  onPressed: () {
                    // do something when button is pressed
                  },
                ),
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
                              bottom:
                                  BorderSide(width: 1.5, color: Colors.white),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Flight Number',
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
                                    'ATD',
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
                                    'ETA',
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
                                    'ATA',
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
                                    'Delay',
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
                                    'Code',
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.topRight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(220, 38, 38, 1)),
                  child: const Text('Create Daily Report'),
                  onPressed: () {
                    // do something when button is pressed
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
