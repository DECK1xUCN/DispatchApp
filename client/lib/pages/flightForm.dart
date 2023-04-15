import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:client/classes/Location.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../classes/Flight.dart';

class FlightForm extends HookWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Flight flight = ModalRoute.of(context)!.settings.arguments as Flight;
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    String flightQuery = """
query MyQuery(\$flightId: Int!) {
  flight(id: \$flightId) {
    etd
    ata
    atd
    blockTime
    cargoPP
    delay
    delayCode
    delayDesc
    delayMin
    eta
    flightTime
    hoistCycles
    notes
    pax
    paxTax
    rotorStart
    rotorStop
    from {
      id
    }
    via {
      id
      name
    }
    to {
      id
    }
  }
  heliports {
    name
    id
  }
  sites {
    name
    id
  }
}
  """;

    final readFlight = useQuery(
      QueryOptions(
          document: gql(flightQuery), variables: {'flightId': flight.id}),
    );
    final result = readFlight.result;

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

    List<Location> locations = [];
    List<Location> sites = [];

    List? listHeliports = result.data?["heliports"];
    List? listSites = result.data?["sites"];

    // Load the data from the query into the _locations list
    for (var location in listHeliports!) {
      locations.add(Location(id: location["id"], name: location["name"]));
    }

    for (var site in listSites!) {
      sites.add(Location(id: site["id"], name: site["name"]));
    }

    final List<String> delayCodes = ["A", "B", "C", "D", "E", "F", "G", "H"];

    List<String> viaLocations = [];

    for (var via in result.data?["flight"]["via"]) {
      viaLocations.add(via["name"]);
    }

    final formState = useState({
      'selectedFrom': locations
          .indexWhere((obj) => obj.id == result.data?['flight']['from']['id']),
      'selectedTo': locations
          .indexWhere((obj) => obj.id == result.data?['flight']['to']['id']),
      'via': viaLocations,
      'dropdownValue': delayCodes.first,
      'ata': DateTime.parse(result.data?["flight"]["ata"]),
      'atd': DateTime.parse(result.data?["flight"]["atd"]),
      'etd': DateTime.parse(result.data?["flight"]["etd"]),
      'blockTime': result.data?["flight"]["blockTime"],
      'cargoPP': result.data?["flight"]["cargoPP"],
      'delay': result.data?["flight"]["delay"],
      'delayCode': result.data?["flight"]["delayCode"],
      'delayDesc': result.data?["flight"]["delayDesc"],
      'delayMin': result.data?["flight"]["delayMin"],
      'eta': DateTime.parse(result.data?["flight"]["eta"]),
      'flightTime': result.data?["flight"]["flightTime"],
      'hoistCycles': result.data?["flight"]["hoistCycles"],
      'notes': result.data?["flight"]["notes"],
      'pax': result.data?["flight"]["pax"],
      'paxTax': result.data?["flight"]["paxTax"],
      'rotorStart': DateTime.parse(result.data?["flight"]["rotorStart"]),
      'rotorStop': DateTime.parse(result.data?["flight"]["rotorStop"]),
    });

    final isDelayed = useState(false);
    void toggleDelay(value) {
      isDelayed.value = !isDelayed.value;
    }

    TextEditingController controllerETD = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['etd']));
    TextEditingController controllerRotorStart = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['rotorStart']));
    TextEditingController controllerATD = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['atd']));
    TextEditingController controllerETA = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['eta']));
    TextEditingController controllerRotorStop = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['rotorStop']));
    TextEditingController controllerATA = TextEditingController(
        text: DateFormat('HH:mm').format(formState.value['ata']));
    TextEditingController controllerDelayReason =
        TextEditingController(text: formState.value['delayDesc']);
    TextEditingController controllerPAX =
        TextEditingController(text: formState.value['pax'].toString());
    TextEditingController controllerPAXTax =
        TextEditingController(text: formState.value['paxTax'].toString());
    TextEditingController controllerCargo =
        TextEditingController(text: formState.value['cargoPP'].toString());
    TextEditingController controllerHoistCycles =
        TextEditingController(text: formState.value['hoistCycles'].toString());
    TextEditingController controllerBlocktime =
        TextEditingController(text: formState.value['blockTime'].toString());
    TextEditingController controllerFlighttime =
        TextEditingController(text: formState.value['flightTime'].toString());
    TextEditingController controllerDelayMin =
        TextEditingController(text: formState.value['delayMin'].toString());

    useEffect(() {
      return () {
        controllerETD.dispose();
        controllerRotorStart.dispose();
        controllerATD.dispose();
        controllerETA.dispose();
        controllerRotorStop.dispose();
        controllerATA.dispose();
        controllerDelayReason.dispose();
        controllerPAX.dispose();
        controllerPAXTax.dispose();
        controllerCargo.dispose();
        controllerHoistCycles.dispose();
        controllerBlocktime.dispose();
        controllerFlighttime.dispose();
        controllerDelayMin.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flight Form ${flight.flightnumber}"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("From", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      locations.length,
                      (index) => GestureDetector(
                          onTap: () {
                            formState.value['selectedFrom'] = index;
                            formState.value = {...formState.value};
                          },
                          child: CardWidget(
                              formState.value['selectedFrom'] == index,
                              locations[index].name)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Via", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  MultiSelectDialogField<String>(
                    initialValue: formState.value['via'],
                    items: sites
                        .map((e) => MultiSelectItem(e.toString(), e.toString()))
                        .toList(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "You must select at least one location!";
                      }
                      return null;
                    },
                    searchable: true,
                    listType: MultiSelectListType.CHIP,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 2),
                    ),
                    cancelText: const Text("Cancel",
                        style: TextStyle(color: Colors.black)),
                    confirmText: const Text("Select",
                        style: TextStyle(color: Colors.black)),
                    itemsTextStyle: const TextStyle(color: Colors.white),
                    unselectedColor: Colors.lightBlueAccent,
                    selectedColor: Colors.greenAccent,
                    selectedItemsTextStyle:
                        const TextStyle(color: Colors.white),
                    separateSelectedItems: true,
                    buttonText: const Text("Select locations"),
                    title: Text("Locations",
                        style: Theme.of(context).textTheme.titleLarge),
                    backgroundColor: Colors.white,
                    searchIcon: const Icon(Icons.search, color: Colors.black),

                    //selectedItemsTextStyle: TextStyle(color: Colors.green),
                    onConfirm: (values) {
                      print(values);
                      formState.value['via'] = values;
                      formState.value = {...formState.value};
                    },
                  ),
                  const SizedBox(height: 20),
                  Text("To", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      locations.length,
                      (index) => GestureDetector(
                        onTap: () {
                          formState.value['selectedTo'] = index;
                          formState.value = {...formState.value};
                        },
                        child: CardWidget(
                          formState.value['selectedTo'] == index,
                          locations[index].name,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ETD",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            //ETD
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  // initialValue: formState.value['etd'].toString(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    try {
                                      DateFormat('HH:mm').parse(value);
                                    } catch (e) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerETD,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['etd']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['etd'] = DateTime(
                                          formState.value['etd'].year,
                                          formState.value['etd'].month,
                                          formState.value['etd'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rotor Start",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            //Rotor Start
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerRotorStart,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['rotorStart']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['rotorStart'] = DateTime(
                                          formState.value['rotorStart'].year,
                                          formState.value['rotorStart'].month,
                                          formState.value['rotorStart'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ATD",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            //ATD
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerATD,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['atd']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['atd'] = DateTime(
                                          formState.value['atd'].year,
                                          formState.value['atd'].month,
                                          formState.value['atd'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ETA",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            //ETA
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerETA,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['eta']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['eta'] = DateTime(
                                          formState.value['eta'].year,
                                          formState.value['eta'].month,
                                          formState.value['eta'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rotor Stop",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // Rotor Stop
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerRotorStop,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['rotorStop']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['rotorStop'] = DateTime(
                                          formState.value['rotorStop'].year,
                                          formState.value['rotorStop'].month,
                                          formState.value['rotorStop'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ATA",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // ATA
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "The must write the time with the following format HH:MM";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  controller: controllerATA,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          formState.value['ata']),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (newTime == null) {
                                      return;
                                    } else {
                                      formState.value['ata'] = DateTime(
                                          formState.value['ata'].year,
                                          formState.value['ata'].month,
                                          formState.value['ata'].day,
                                          newTime.hour,
                                          newTime.minute);
                                      formState.value = {...formState.value};
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Block Time",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // Block Time
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field cannot be empty";
                                  }
                                  try {
                                    int newVal = int.parse(value);
                                    if( newVal < 0) {
                                      return "Block Time cannot be negative";
                                    }
                                  } catch (e) {
                                    return "Filed must be a number";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                controller: controllerBlocktime,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Flight Time",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // Flight Time
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field cannot be empty";
                                  }
                                  try {
                                    int newVal = int.parse(value);
                                    if( newVal < 0) {
                                      return "Flight Time cannot be negative";
                                    }
                                  } catch (e) {
                                    return "Filed must be a number";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                controller: controllerFlighttime,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Delay",
                          style: Theme.of(context).textTheme.titleLarge),
                      Switch(
                        onChanged: toggleDelay,
                        value: isDelayed.value,
                        activeColor: Colors.lightBlue,
                        activeTrackColor: Colors.lightBlueAccent,
                        inactiveThumbColor: Colors.grey[200],
                        inactiveTrackColor: Colors.grey[400],
                      ),
                    ],
                  ),
                  if (isDelayed.value) ...[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Minutes",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 10),
                              SizedBox(
                                // Delay amount
                                width: 150,
                                height: 50,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "This field must not be empty";
                                      }
                                      try {
                                        int newVal = int.parse(value);
                                        if( newVal < 0) {
                                          return "Delay Time cannot be negative";
                                        }
                                      } catch (e) {
                                        return "Filed must be a number";
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    controller: controllerDelayMin,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delay Reason",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 10),
                              SizedBox(
                                // Delay Reason
                                width: 150,
                                height: 60,
                                child: DropdownButtonFormField<String>(
                                  value: formState.value['dropdownValue']
                                      .toString(),
                                  icon: const Icon(Icons.arrow_downward),
                                  dropdownColor: Colors.white,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    formState.value['dropdownValue'] = value!;
                                    formState.value = {...formState.value};
                                  },
                                  items: delayCodes
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 150)
                        ]),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delay Description",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Scrollbar(
                          // Delay desc
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: SizedBox(
                              width: 400,
                              height: 200,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field must not be empty";
                                  }
                                  return null;
                                },
                                controller: controllerDelayReason,
                                maxLines: 100,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PAX",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // PAX
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field must not be empty";
                                }
                                try {
                                  int newVal = int.parse(value);
                                  if( newVal < 0) {
                                    return "PAX cannot be negative";
                                  }
                                } catch (e) {
                                  return "Filed must be a number";
                                }
                                return null;
                              },
                              controller: controllerPAX,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PAX Tax",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // PAX Tax
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field must not be empty";
                                }
                                try {
                                  int newVal = int.parse(value);
                                  if( newVal < 0) {
                                    return "PAX Tax cannot be negative";
                                  }
                                } catch (e) {
                                  return "Filed must be a number";
                                }
                                return null;
                              },
                              controller: controllerPAXTax,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cargo (PP)",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 10),
                          SizedBox(
                            // Cargo
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field must not be empty";
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  int newVal = int.parse(value);
                                  if( newVal < 0) {
                                    return "Cargo cannot be negative";
                                  }
                                }
                                return null;
                              },
                              controller: controllerCargo,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hoist Cycles",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      SizedBox(
                        // Hoist cycles
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field must not be empty";
                            }
                            try {
                              int newVal = int.parse(value);
                              if( newVal < 0) {
                                return "Hoist Cycles cannot be negative";
                              }
                            } catch (e) {
                              return "Filed must be a number";
                            }
                            return null;
                          },
                          controller: controllerHoistCycles,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (formKey.currentState!.validate() &&
                            formState.value['selectedFrom'] != -1 &&
                            formState.value['selectedTo'] != -1) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          print(formState.value);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: A card widget already exists, try and combine this two for less code duplication
class CardWidget extends StatelessWidget {
  final bool selected;
  final String index;

  const CardWidget(this.selected, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        border:
            Border.all(color: selected ? Colors.lightBlueAccent : Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(index),
      ),
    );
  }
}
