import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart'; //Multi select dropdown

class FlightForm extends StatefulWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  State<FlightForm> createState() => _FlightFormState();
}

//Temp mock data
class City {
  final int id;
  final String name;

  City({required this.id, required this.name});
}

class _FlightFormState extends State<FlightForm> {
  TimeOfDay timeETA = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  int id = 1;
  bool isSwitched = false;
  int sitesCount = 5;

  // Dat for the From and To Sites
  int selectedFrom = -1;
  int selectedTo = -1;

  static List<City> _cities = [
    City(id: 0, name: "Aalborg"),
    City(id: 1, name: "Coppenhagen"),
    City(id: 2, name: "London"),
    City(id: 3, name: "Dublin")
  ];

  static List<String> _delayCodes = ["A", "B", "C", "D", "E", "F", "G", "H"];
  String dropdownValue = _delayCodes.first;

  // Data for the Via Sites
  List<City> _selectedCities = [];

  // TextEditingControllers are used to set initial data in the TextFormFields and then get those data later
  TextEditingController _controllerFlightNumber = new TextEditingController(); //This might be unnecessary
  TextEditingController _controllerETD = new TextEditingController();
  TextEditingController _controllerRotorStart = new TextEditingController();
  TextEditingController _controllerATD = new TextEditingController();
  TextEditingController _controllerETA = new TextEditingController();
  TextEditingController _controllerRotorStop = new TextEditingController();
  TextEditingController _controllerATA = new TextEditingController();
  TextEditingController _controllerBlockTime = new TextEditingController();
  TextEditingController _controllerFlightTime = new TextEditingController();
  TextEditingController _controllerDelayAmount = new TextEditingController();
  TextEditingController _controllerDelayReason = new TextEditingController(); //This might also be unnecessary
  TextEditingController _controllerDelayDescription = new TextEditingController();
  TextEditingController _controllerPAX = new TextEditingController();
  TextEditingController _controllerPAXTax = new TextEditingController();
  TextEditingController _controllerCargo = new TextEditingController();
  TextEditingController _controllerHoistCycles = new TextEditingController();

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  void setTime(TextEditingController _controller, TimeOfDay newTime) {
    _controller.addListener(() {
      setState(() {
        String hours = newTime.hour.toString().padLeft(2, '0');
        String minutes = newTime.minute.toString().padLeft(2, '0');
        _controller.text = "$hours:$minutes";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Set initial display time for time pickers
    setTime(_controllerETD, time);
    _controllerRotorStart.text = _controllerETD.text;
    _controllerATD.text = _controllerETD.text;
    _controllerETA.text = "${time.hour + 1}:${time.minute}";
    _controllerRotorStop.text = _controllerETA.text;
    _controllerATA.text = _controllerETA.text;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ID, $id",
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Flight Number",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge, //TODO: Store Text style in a variable to lessen code duplication or change it in main.dart
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Flight Number",
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                  Text("From", style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      _cities.length,
                      (index) => GestureDetector(
                          onTap: () => setState(() => selectedFrom = index),
                          child: CardWidget(
                              selectedFrom == index, "${_cities[index].name}")),
                    ),
                  ),
                  Text("Via", style: Theme.of(context).textTheme.titleLarge),
                  MultiSelectDialogField(
                    items:
                        _cities.map((e) => MultiSelectItem(e, e.name)).toList(),
                    searchable: true,
                    listType: MultiSelectListType.CHIP,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 2),
                    ),
                    cancelText:
                        Text("Cancel", style: TextStyle(color: Colors.black)),
                    confirmText:
                        Text("Select", style: TextStyle(color: Colors.black)),
                    itemsTextStyle: TextStyle(color: Colors.white),
                    unselectedColor: Colors.lightBlueAccent,
                    selectedColor: Colors.greenAccent,
                    selectedItemsTextStyle: TextStyle(color: Colors.white),
                    separateSelectedItems: true,
                    buttonText: Text("Select cities"),
                    title: Text("Cities",
                        style: Theme.of(context).textTheme.titleLarge),
                    backgroundColor: Colors.white,

                    //selectedItemsTextStyle: TextStyle(color: Colors.green),
                    onConfirm: (values) {
                      _selectedCities = values;
                    },
                  ),
                  Text("From", style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      _cities.length,
                      (index) => GestureDetector(
                        onTap: () => setState(() => selectedTo = index),
                        child: CardWidget(
                          selectedTo == index,
                          _cities[index].name,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ETD",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("Rotor Start",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("ATD",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container( //ETD
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerETD,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerETD, newTime);
                                }),
                          ),
                        ),
                        Container( //Rotor Start
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerRotorStart,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerRotorStart, newTime);
                                }),
                          ),
                        ),
                        Container( //ATD
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerATD,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerATD, newTime);
                                }),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ETA",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("Rotor Stop",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("ATA",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container( //ETA
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerETA,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerETA, newTime);
                                }),
                          ),
                        ),
                        Container( // Rotor Stop
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerRotorStop,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerRotorStop, newTime);
                                }),
                          ),
                        ),
                        Container( // ATA
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerATA,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerATA, newTime);
                                }),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Block Time",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("Flight Time",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container( // Block Time
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerBlockTime,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerETD, newTime);
                                }),
                          ),
                        ),
                        Container( // Flight Time
                          width: 150,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                autofocus: false,
                                controller: _controllerFlightTime,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (newTime == null) return;
                                  setTime(_controllerATD, newTime);
                                }),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(children: [
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
                          ]),
                        ],
                      ),
                      if (isSwitched) ...[
                        Column(
                          children: [
                            Text("Delay Reason",
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ],
                    ],
                  ),
                  if (isSwitched) ...[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container( // Delay amount
                            width: 150,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                autofocus: false,
                                controller: _controllerDelayAmount,
                                style: TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Container( // Delay Reason
                            width: 150,
                            height: 60,
                            child: DropdownButtonFormField<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: _delayCodes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        Text("Delay Description",
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                    Row(
                      children: [
                        Scrollbar( // Delay desc
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: SizedBox(
                              width: 400,
                              height: 200,
                              child: TextFormField(
                                controller: _controllerDelayReason,
                                maxLines: 100,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("PAX",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("PAX Tax",
                          style: Theme.of(context).textTheme.titleLarge),
                      Text("Cargo (per person)",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container( // PAX
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _controllerPAX,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container( // PAX Tax
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _controllerPAXTax,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container( // Cargo
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _controllerCargo,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row( //Prob delete this later
                    children: [
                      Text("Hoist Cycles",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Row(
                    children: [
                      Container( // Hoist cycles
                        width: 150,
                        height: 50,
                        child: TextFormField(
                          controller: _controllerHoistCycles,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
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
//TODO: Customize the container that holds it, so it looks normal
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(index),
      ),
    );
  }
}
