import 'package:client/classes/Location.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Sites extends StatefulWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  State<Sites> createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  List<Widget> generateRows(list) {
    List<Location> sites = [];

    for (var site in list) {
      List<Location> via = [];

      sites.add(Location(
        id: site['id'],
        name: site['name'],
      ));
    }

    List<Widget> rows = [];
    for (var site in sites) {
      rows.add(GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, '/flightform', arguments: flight);
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
                    site.id.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                ),
                Expanded(
                  child: Center(
                      child: Text(
                    site.name,
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

  String sitesQuery = """
query MyQuery {
  sites {
    id
    name
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(sitesQuery),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return const SafeArea(
                child: Center(
                    child: Text("An error occurred, check the console :(")));
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List? sitesList = result.data?["sites"];
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'sitesButton',
              onPressed: () {},
              backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
              label: const Text('Add site'),
              icon: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 65),
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
                                          'ID',
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
                                          'Name',
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
                              ...generateRows(sitesList)
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
