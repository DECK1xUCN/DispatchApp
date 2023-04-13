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

    TimeOfDay time = const TimeOfDay(hour: 24, minute: 00);
    int id = 1;

    // Data for the Via Sites
    List<Location> selectedLocations = [];

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
  }
  heliports {
    name
    id
  }
}
  """;

    final readFlight = useQuery(
      QueryOptions(
        document: gql(flightQuery),
        variables: {'flightId': flight.id}
      ),
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

    List? list = result.data?["heliports"];

    // Load the data from the query into the _locations list
    for (var location in list!) {
      locations.add(Location(id: location["id"], name: location["name"]));
    }

    final List<String> delayCodes = ["A", "B", "C", "D", "E", "F", "G", "H"];

    final formState = useState({
      'selectedFrom': -1,
      'selectedTo': -1,
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

    print(formState.value['ata']);

    final isDelayed = useState(false);
    void toggleDelay(value) {
      isDelayed.value = !isDelayed.value;
    }

    TextEditingController controllerETD = TextEditingController(text: DateFormat('HH:mm').format(formState.value['etd']));
    TextEditingController controllerRotorStart = TextEditingController();
    TextEditingController controllerATD = TextEditingController();
    TextEditingController controllerETA = TextEditingController();
    TextEditingController controllerRotorStop = TextEditingController();
    TextEditingController controllerATA = TextEditingController();
    TextEditingController controllerDelayReason = TextEditingController();
    TextEditingController controllerPAX = TextEditingController(text: formState.value['pax'].toString());
    TextEditingController controllerPAXTax = TextEditingController(text: formState.value['paxTax'].toString());
    TextEditingController controllerCargo = TextEditingController(text: formState.value['cargoPP'].toString());
    TextEditingController controllerHoistCycles = TextEditingController(text: formState.value['hoistCycles'].toString());

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
                  MultiSelectDialogField(
                    initialValue: flight.via,
                    items: locations
                        .map((e) => MultiSelectItem(e, e.toString()))
                        .toList(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "You must select at least one site!";
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

                    //selectedItemsTextStyle: TextStyle(color: Colors.green),
                    onConfirm: (values) {
                      selectedLocations = values;
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
                                // initialValue: formState.value['etd'].toString(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerETD.text = "$hours:$minutes";
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerRotorStart.text =
                                          "$hours:$minutes";
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerATD.text = "$hours:$minutes";
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerETA.text = "$hours:$minutes";
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerRotorStop.text =
                                          "$hours:$minutes";
                                    }
                                  }),
                            ),
                          ),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
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
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      controllerATA.text = "$hours:$minutes";
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  // controller: controllerBlockTime,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      // controllerBlockTime.text =
                                      //     "$hours:$minutes";
                                    }
                                  }),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field cannot be empty";
                                    }
                                    if (!value.contains(':')) {
                                      return "This field must contain this ':' character";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  // controller: controllerFlightTime,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: time,
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
                                      String hours = newTime.hour
                                          .toString()
                                          .padLeft(2, '0');
                                      String minutes = newTime.minute
                                          .toString()
                                          .padLeft(2, '0');
                                      // controllerFlightTime.text =
                                          // "$hours:$minutes";
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 150,
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "This field must not be empty";
                                      }
                                      try {
                                        int.parse(value);
                                      } catch (e) {
                                        return "Filed must be a number";
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    // controller: controllerDelayAmount,
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
                                  int.parse(value);
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
                                  int.parse(value);
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
                                  return "Filed must be a number";
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
                              int.parse(value);
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
