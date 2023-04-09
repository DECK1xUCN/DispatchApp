import 'package:client/classes/Flight.dart';
import 'package:client/classes/Location.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  List<Widget> generateRows(list) {
    for (var flight in list) {
      print(flight);
      print(flight['etd']);
      print(flight['flightNumber']);
      print(flight['from']);
      print(flight['via']);
      print(flight['to']);

      List<Location> via = [];

      for (var location in flight['via']) {
        via.add(Location(id: location['id'], name: location['name']));
      }

      Flight(
        etd: DateTime.parse(flight['etd']),
        flightnumber: flight['flightNumber'],
        from: Location(id: flight['from']['id'], name: flight['from']['name']),
        via: via,
        to: Location(id: flight['to']['id'], name: flight['to']['name'])
      );
    }
    return [Text('test1'), Text('test1')];
  }

  // List<Widget> generateRows() {
  //   List<Widget> rows = [];
  //   for (var element in flights) {
  //     rows.add(GestureDetector(
  //       onTap: () {
  //         Navigator.pushNamed(context, '/flightform', arguments: element);
  //       },
  //       child: Container(
  //           height: 50,
  //           decoration: const BoxDecoration(),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Expanded(
  //                 child: Center(
  //                     child: Text(
  //                   DateFormat.Hm().format(element.etd),
  //                   style: const TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 )),
  //               ),
  //               Expanded(
  //                 child: Center(
  //                     child: Text(
  //                   element.flightnumber,
  //                   style: const TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 )),
  //               ),
  //               Expanded(
  //                 child: Center(
  //                     child: Text(
  //                   element.from,
  //                   style: const TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 )),
  //               ),
  //               Expanded(
  //                 child: Center(
  //                     child: Text(
  //                   element.via.toString(),
  //                   style: const TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 )),
  //               ),
  //               Expanded(
  //                 child: Center(
  //                     child: Text(
  //                   element.to,
  //                   style: const TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 )),
  //               ),
  //             ],
  //           )),
  //     ));
  //   }
  //   return rows;
  // }

  String flightsQuery = """
query MyQuery {
  flights {
    etd
    flightNumber
    from {
      id
      name
    }
    via {
      id
      name
    }
    to {
      id
      name
    }
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(flightsQuery),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return SafeArea(child: Text(result.exception.toString()));
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List? flightList = result.data?["flights"];

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
                      ),
                      child: const Text('New Flight'),
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
                                    bottom: BorderSide(
                                        width: 1.5, color: Colors.white),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                              ...?generateRows(flightList)
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
        });
  }
}
