import 'package:client/classes/Flight.dart';
import 'package:client/classes/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  List<Widget> generateRows(list) {
    List<Flight> flights = [];

    for (var flight in list) {
      List<Location> via = [];

      for (var location in flight['via']) {
        via.add(Location(id: location['id'], name: location['name']));
      }

      flights.add(Flight(
          etd: DateTime.parse(flight['etd']),
          flightnumber: flight['flightNumber'],
          from:
              Location(id: flight['from']['id'], name: flight['from']['name']),
          via: via,
          to: Location(id: flight['to']['id'], name: flight['to']['name'])));
    }

    List<Widget> rows = [];
    for (var flight in flights) {
      rows.add(GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/flightform', arguments: flight);
        },
        child: Container(
            height: 50,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    DateFormat.Hm().format(flight.etd),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    flight.flightnumber,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    flight.from.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    flight.via.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    flight.to.toString(),
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
            return const SafeArea(
                child: Center(
                    child: Text("An error occurred, check the console :(")));
          }
          if (result.isLoading) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFoldingCube(
                  color: Color.fromRGBO(163, 160, 251, 1),
                  size: 50.0,
                ),
              ),
            );
          }

          List? flightList = result.data?["flights"];
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'flightsButton',
              onPressed: () {},
              backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
              label: const Text('Generate DFR'),
              icon: const Icon(Icons.add_chart),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              refetch!();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 42,
                              color: Color.fromRGBO(163, 160, 251, 1),
                            )),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(163, 160, 251, 1),
                          ),
                          child: const Text('New Flight'),
                          onPressed: () {},
                        ),
                      ],
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
                              ...generateRows(flightList)
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
