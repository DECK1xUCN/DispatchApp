import 'package:client/classes/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import '../classes/flight_simple.dart';

class Flights extends HookWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    dailyUpdate {
      id
    }
    site {
      id
    }
  }
}
  """;

    String dailyUpdateFineMutation = """
mutation MyMutation(\$flightId: Int!) {
  createDailyUpdate(
    input: {wasFlight: true, delay: false, maintenance: false, baseAndEquipment: false, flightId: \$flightId}
  ) {
    delay
    flight {
      id
    }
    baseAndEquipment
    maintenance
  }
}
    """;

    final dailyUpdateFine = useMutation(
      MutationOptions(
        document: gql(dailyUpdateFineMutation),
      ),
    );

    final readFlights = useQuery(
      QueryOptions(
        document: gql(flightsQuery),
        pollInterval: const Duration(seconds: 2),
      ),
    );
    final result = readFlights.result;

    if (result.hasException) {
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
    List<FlightSimple> flights = [];

    for (var flight in flightList!) {
      var flightObject = FlightSimple(
          id: flight['id'],
          etd: DateTime.parse(flight['etd']),
          flightnumber: flight['flightNumber'],
          from:
              Location(id: flight['from']['id'], name: flight['from']['name']),
          to: Location(id: flight['to']['id'], name: flight['to']['name']),
          siteId: flight['site']['id']);

      if (flight['dailyUpdate'] != null) {
        flightObject.hasDU = true;
      }

      flights.add(flightObject);
    }

    flights.sort((a, b) => a.etd.compareTo(b.etd));

    List<Widget> generateRows(flights) {
      List<Widget> rows = [];
      for (var flight in flights) {
        rows.add(GestureDetector(
          onTap: () {
            if (flight.hasDU) return;
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      flight.flightnumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      flight.from.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      flight.to.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ),
                  Expanded(
                      child: Center(
                          child: !flight.hasDU
                              ? ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text(
                                              'Was flight ${flight.flightnumber} completed?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      dailyUpdateFine
                                                          .runMutation({
                                                        'flightId': flight.id
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                    ),
                                                    child: Text(
                                                      'Completed',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    )),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/dailyUpdateForm',
                                                          arguments: flight);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              249, 206, 85, 1),
                                                    ),
                                                    child: Text('Not completed',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium)),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.assignment,
                                      color: Colors.white),
                                  label: Text('Update',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                )
                              : const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ))),
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
        backgroundColor: const Color.fromRGBO(9, 166, 215, 1),
        label: Text('Generate DFR',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.description, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
