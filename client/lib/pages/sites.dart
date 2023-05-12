import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../classes/Location.dart';
import '../classes/Site.dart';

class Sites extends HookWidget {
  const Sites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String selectedId = '';

    String sitesQuery = """
query MyQuery {
  sites {
    id
    name
  }
}
  """;

    String locationQuerry = """   
query MyQuery {
  locations {
    id
    name
    lat
    lng
    type
    site {
      id
      name
    }
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
        document: gql(sitesQuery),
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

    final readLocations = useQuery(
      QueryOptions(
        document: gql(locationQuerry), // this is the query string you ju st created
        pollInterval: const Duration(seconds: 10),
      ),
    );

    final locationResult = readLocations.result;

    if (locationResult.hasException) {
      print(locationResult.exception.toString());
      return const SafeArea(
          child:
          Center(child: Text("An error occurred, check the console :(")));
    }


    if (result.isLoading && locationResult.isLoading) {
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

    List? locationList = locationResult.data?["locations"];
    List? sitesList = result.data?["sites"];
    final dropdownValue = useState(sitesList![0]['id']);

    final addSite = useMutation(
      MutationOptions(
        document: gql(createSite),
      ),
    );



    List<Widget> generateRows(list) {


      List<Site> sites = [];

      for (var site in list) {
        sites.add(Site(
          id: site['id'],
          name: site['name'],
        ));
      }

   List<Location> locs = [];
      for (var location in list) {
        locs.add(Location(
            id: location['id'],
            name: location['name'],
            lat: location['lat'],
            lon: location['lng'],
            type: location['type'],
            site: Site(
              id: location['site']['id'],
              name: location['site']['name'],
            ),
          ),
        );
      }


      List<Widget> rows = [];
      for (var location in locs) {
        if (location.site?.id.toString() == dropdownValue.value.toString()) {
          rows.add(GestureDetector(
            onTap: () {},
            child: Container(
                height: 50,
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                          child: Text(
                            location.name,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                            location.type ?? 'No type',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                            location.site?.name ?? 'No site',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                            'Lat: ${location.lat}, Lon: ${location.lon}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),

                  ],
                )),
          ));
        }
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
              child: DropdownButton<String>(

                value: dropdownValue.value.toString(),
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                  color: Colors.black,
                ),
                dropdownColor: Colors.white,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  dropdownValue.value = value!.toString();
                },
                items:  sitesList
                    .map<DropdownMenuItem<String>>((site) => DropdownMenuItem<String>(
                  value: site['id'].toString(),
                  child: Text(site['name'].toString()),
                ))
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.5, color: Colors.white),
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
                                      'Type',
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
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Location',
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
                          ...generateRows(locationList),
                        ],
                      ),
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
