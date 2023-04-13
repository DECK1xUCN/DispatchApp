import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:client/classes/Location.dart';

import '../classes/Flight.dart';

class FlightForm extends StatefulWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  State<FlightForm> createState() => _FlightFormState();
}

class _FlightFormState extends State<FlightForm> {
  final _formKey = GlobalKey<FormState>();

  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  int id = 1;
  bool isSwitched = false;

  int selectedFrom = -1;
  int selectedTo = -1;

  static final List<String> _delayCodes = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H"
  ];
  String dropdownValue = _delayCodes.first;
  // Data for the Via Sites
  List<Location> _selectedLocations = [];

  // TextEditingControllers are used to set initial data in the TextFormFields and then get those data later
  final TextEditingController _controllerFlightNumber =
      TextEditingController(); //This might be unnecessary
  final TextEditingController _controllerETD = TextEditingController();
  final TextEditingController _controllerRotorStart = TextEditingController();
  final TextEditingController _controllerATD = TextEditingController();
  final TextEditingController _controllerETA = TextEditingController();
  final TextEditingController _controllerRotorStop = TextEditingController();
  final TextEditingController _controllerATA = TextEditingController();
  final TextEditingController _controllerBlockTime = TextEditingController();
  final TextEditingController _controllerFlightTime = TextEditingController();
  final TextEditingController _controllerDelayAmount = TextEditingController();
  final TextEditingController _controllerDelayReason =
      TextEditingController(); //This might also be unnecessary
  final TextEditingController _controllerPAX = TextEditingController();
  final TextEditingController _controllerPAXTax = TextEditingController();
  final TextEditingController _controllerCargo = TextEditingController();
  final TextEditingController _controllerHoistCycles = TextEditingController();

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }



  @override
  void dispose() {
    _controllerFlightNumber.dispose();
    _controllerETD.dispose();
    _controllerRotorStart.dispose();
    _controllerATD.dispose();
    _controllerETA.dispose();
    _controllerRotorStop.dispose();
    _controllerATA.dispose();
    _controllerBlockTime.dispose();
    _controllerFlightTime.dispose();
    _controllerDelayAmount.dispose();
    _controllerDelayReason.dispose();
    _controllerPAX.dispose();
    _controllerPAXTax.dispose();
    _controllerCargo.dispose();
    _controllerHoistCycles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Flight flight = ModalRoute.of(context)!.settings.arguments as Flight;
    String flightQuery = """
query MyQuery {
  flight(id: ${flight.id}) {
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

    return Query(
        options: QueryOptions(
          document: gql(flightQuery),
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



          List<Location> _locations = [];

          List? list = result.data?["heliports"];
          // Load data from the query into the flight object
          flight.ata = DateTime.parse(result.data?["flight"]["ata"]);
          flight.atd = DateTime.parse(result.data?["flight"]["atd"]);
          flight.blockTime = result.data?["flight"]["blockTime"];
          flight.cargoPP = result.data?["flight"]["cargoPP"];
          flight.delay = result.data?["flight"]["delay"];
          flight.delayCode = result.data?["flight"]["delayCode"];
          flight.delayDesc = result.data?["flight"]["delayDesc"];
          flight.delayMin = result.data?["flight"]["delayMin"];
          flight.eta = DateTime.parse(result.data?["flight"]["eta"]);
          flight.flightTime = result.data?["flight"]["flightTime"];
          flight.hoistCycles = result.data?["flight"]["hoistCycles"];
          flight.notes = result.data?["flight"]["notes"];
          flight.pax = result.data?["flight"]["pax"];
          flight.paxTax = result.data?["flight"]["paxTax"];
          flight.rotorStart = DateTime.parse(result.data?["flight"]["rotorStart"]);
          flight.rotorStop = DateTime.parse(result.data?["flight"]["rotorStop"]);


          // Load the data from the query into the _locations list
          for (var location in list!) {
            print(location);
            _locations.add(Location(id: location["id"], name: location["name"]));
            print(_locations.length);
          }
          // Set the initial data for the TextFormFields
          _controllerFlightNumber.text = flight.flightnumber;
          _controllerETD.text = ("${flight.etd.hour.toString().padLeft(2, '0')}:${flight.etd.minute.toString().padLeft(2, '0')}");
          _controllerRotorStart.text = flight.rotorStart == null
              ? _controllerETD.text
              : ("${flight.rotorStart?.hour.toString().padLeft(2, '0')}:${flight.rotorStart?.minute.toString().padLeft(2, '0')}");
          _controllerATD.text = flight.atd == null
              ? _controllerETD.text
              : ("${flight.atd?.hour.toString().padLeft(2, '0')}:${flight.atd?.minute.toString().padLeft(2, '0')}");
          _controllerETA.text = ("${flight.eta?.hour.toString().padLeft(2, '0')}:${flight.eta?.minute.toString().padLeft(2, '0')}");
          _controllerRotorStop.text = flight.rotorStop == null
              ? _controllerETA.text
              : ("${flight.rotorStop?.hour.toString().padLeft(2, '0')}:${flight.rotorStop?.minute.toString().padLeft(2, '0')}");
          _controllerATA.text = flight.ata == null
              ? _controllerETA.text
              : ("${flight.ata?.hour.toString().padLeft(2, '0')}:${flight.ata?.minute.toString().padLeft(2, '0')}");
          _controllerBlockTime.text = "${flight.rotorStop?.difference(flight.rotorStart!).inMinutes.toString()}";
          _controllerFlightTime.text = "${flight.ata?.difference(flight.etd).inMinutes.toString()}";
          _controllerDelayAmount.text = flight.delayMin.toString();
          _controllerDelayReason.text = flight.delayDesc.toString();
          _controllerPAX.text = flight.pax.toString();
          _controllerPAXTax.text = flight.paxTax.toString();
          _controllerCargo.text = flight.cargoPP.toString();
          _controllerHoistCycles.text = flight.hoistCycles.toString();
          //_controllerNotes.text = flight.notes;

          @override
          void initState() {
            // TODO: implement initState

            super.initState();
          }

          if (flight.via.isNotEmpty) {
            _selectedLocations = flight.via;
          }

          if (flight.delay == true) {
            isSwitched = true;
            _controllerDelayAmount.text = "${flight.ata?.difference(flight.etd!).inMinutes.toString()}";
            _controllerDelayReason.text = flight.delayDesc.toString();
          }



          if (flight.from != null) {
            selectedFrom = _locations.indexWhere((element) => element.id == flight.from.id);
          }

          if (flight.to != null) {
            selectedTo = _locations.indexWhere((element) => element.id == flight.to.id);
          }

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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("From",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            _locations.length,
                            (index) => GestureDetector(
                                onTap: () =>
                                    setState(() => selectedFrom = index),
                                child: CardWidget(selectedFrom == index,
                                    _locations[index].name)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Via",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        MultiSelectDialogField(
                          initialValue: flight.via,
                          items: _locations
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
                            border:
                                Border.all(color: Colors.lightBlue, width: 2),
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
                            _selectedLocations = values;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text("To",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            _locations.length,
                            (index) => GestureDetector(
                              onTap: () => setState(() => selectedTo = index),
                              child: CardWidget(
                                selectedTo == index,
                                _locations[index].name,
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 10),
                                SizedBox(
                                  //ETD
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
                                        controller: _controllerETD,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerETD.text =
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
                                Text("Rotor Start",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerRotorStart,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerRotorStart.text =
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerATD,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerATD.text =
                                                "$hours:$minutes";
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerETA,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerETA.text =
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
                                Text("Rotor Stop",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerRotorStop,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerRotorStop.text =
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerATA,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerATA.text =
                                                "$hours:$minutes";
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerBlockTime,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerBlockTime.text =
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
                                Text("Flight Time",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                        controller: _controllerFlightTime,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: time,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
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
                                            _controllerFlightTime.text =
                                                "$hours:$minutes";
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
                              onChanged: toggleSwitch,
                              value: isSwitched,
                              activeColor: Colors.lightBlue,
                              activeTrackColor: Colors.lightBlueAccent,
                              inactiveThumbColor: Colors.grey[200],
                              inactiveTrackColor: Colors.grey[400],
                            ),
                          ],
                        ),
                        if (isSwitched) ...[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Minutes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
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
                                          controller: _controllerDelayAmount,
                                          style: const TextStyle(
                                              color: Colors.black),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      // Delay Reason
                                      width: 150,
                                      height: 60,
                                      child: DropdownButtonFormField<String>(
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_downward),
                                        dropdownColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue = value!;
                                          });
                                        },
                                        items: _delayCodes
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
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
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
                                      controller: _controllerDelayReason,
                                      maxLines: 100,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                    controller: _controllerPAX,
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                    controller: _controllerPAXTax,
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
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
                                    controller: _controllerCargo,
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
                                controller: _controllerHoistCycles,
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
                              if (_formKey.currentState!.validate() &&
                                  selectedFrom != -1 &&
                                  selectedTo != -1) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
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
        });
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
