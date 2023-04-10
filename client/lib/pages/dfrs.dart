import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../classes/Dfr.dart';
import 'dfrsWithId.dart';

class DFRs extends StatefulWidget {
  const DFRs({Key? key}) : super(key: key);

  @override
  _DFRsState createState() => _DFRsState();
}

class _DFRsState extends State<DFRs> {
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
    Dfr(
      id: 125,
      model: 'EC 145',
      registration: 'D-HOTT',
      date: DateTime.now(),
      pilot: 'SRO',
      hoistOperator: 'BRA',
      dailyUpdate: false,
    ),
    Dfr(
      id: 126,
      model: 'AS 332 L1',
      registration: 'D-HPIA',
      date: DateTime.now(),
      pilot: 'MHO',
      hoistOperator: 'MBO',
      dailyUpdate: true,
    ),
    Dfr(
      id: 127,
      model: 'AS 332 L1',
      registration: 'D-HPIA',
      date: DateTime.now(),
      pilot: 'MHO',
      hoistOperator: 'MBO',
      dailyUpdate: false,
    ),
    Dfr(
      id: 128,
      model: 'EC 135',
      registration: 'D-HBWV',
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DFRsWithId()),
          );
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
                    DateFormat.yMMMMd().format(element.date),
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
                'DFRs',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
                ),
                child: const Text('New Report'),
                onPressed: () {},
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
                                    'Id',
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
                                    'A/C Model',
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
                                    'A/C Registration',
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
                                    'Date',
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
                                    'Pilot',
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
                                    'Hoist Operator',
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
                                    'Daily Update',
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
