import 'package:client/classes/Flight.dart';
import 'package:client/classes/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import '../classes/delayCodes.dart';

class Flights extends HookWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DelayCode dropdownValue = DelayCode.A_HeliWeather;

    String flightsQuery = """
query MyQuery {
  flights {
    id
    etd
    flightNumber
    from {
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

    final readFlights = useQuery(
      QueryOptions(
        document: gql(flightsQuery),
        pollInterval: const Duration(seconds: 2),
      ),
    );
    final result = readFlights.result;

    if (result.hasException) {
      print(result.exception.toString());
      return const SafeArea(
          child:
              Center(child: Text("An error occurred, check the console :(")));
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
    List<Flight> flights = [];

    for (var flight in flightList!) {
      flights.add(Flight(
          id: flight['id'],
          etd: DateTime.parse(flight['etd']),
          flightnumber: flight['flightNumber'],
          from:
              Location(id: flight['from']['id'], name: flight['from']['name']),
          to: Location(id: flight['to']['id'], name: flight['to']['name']),
          hasDU: false));
    }

    List<Widget> generateRows(flights) {
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
                          flight.to.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                  Expanded(
                      child: Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: flight.hasDU
                                ? const Color.fromRGBO(113, 216, 150, 1)
                                : const Color.fromRGBO(9, 166, 215, 1),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor: Colors.white,
                                      scrollable: true,
                                      title: const Text(
                                          "Please select the flight status:"),
                                      content: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              //todo: add mutation to update flight with DU
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(" Complete "),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              //todo: add extra details for DU
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Incomplete"),
                                          ),
                                        ],
                                      ));
                                });
                          },
                          icon: const Icon(Icons.update),
                          label: const Text('Update'),
                        ),
                      )),
                ],
              )),
        ));
      }
      return rows;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'flightsButton',
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(0, 66, 106, 1),
        label: const Text('Generate DFR'),
        icon: const Icon(Icons.add_chart),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  'Update',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        ...generateRows(flights)
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
