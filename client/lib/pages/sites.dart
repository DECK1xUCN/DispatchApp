import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../classes/location.dart';

class Sites extends HookWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String sitesQuery = """
query MyQuery {
  sites {
    id
    name
  }
}
  """;

    String createSite = """   
mutation MyMutation(\$siteName: String!) {
  createSite(data: {name: \$siteName}) {
    id
    name
  }
}
    """;

    final readSites = useQuery(
      QueryOptions(
        document: gql(sitesQuery), // this is the query string you just created
        pollInterval: const Duration(seconds: 10),
      ),
    );
    final result = readSites.result;

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

    List? sitesList = result.data?["sites"];

    final addSite = useMutation(
      MutationOptions(
        document: gql(createSite),
      ),
    );

    List<Widget> generateRows(list) {
      List<Location> sites = [];

      for (var site in list) {
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

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'sitesButton',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  scrollable: true,
                  title: const Text('Add site'),
                  content: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) {
                            addSite.runMutation({'siteName': value});
                            Navigator.pop(context);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.black),
                            icon:
                                Icon(Icons.flight_takeoff, color: Colors.black),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            label: const Text("Cancel"),
                            icon: const Icon(Icons.cancel),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        ElevatedButton.icon(
                            label: const Text("Add"),
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                              }
                            })
                      ],
                    )
                  ],
                );
              });
        },
        backgroundColor: const Color.fromRGBO(163, 160, 251, 1),
        label: const Text('Add site'),
        icon: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
              child: IconButton(
                  onPressed: () {
                    readSites;
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 42,
                    color: Color.fromRGBO(163, 160, 251, 1),
                  )),
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
  }
}
