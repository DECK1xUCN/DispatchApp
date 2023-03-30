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
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  int id = 1;
  bool isSwitched = false;
  int sitesCount = 5;
  int selectedFrom = -1;
  int selectedTo = -1;
  static List<City> _cities = [
    City(id: 0, name: "Aalborg"),
    City(id: 1, name: "Coppenhagen"),
    City(id: 2, name: "London"),
    City(id: 3, name: "Dublin")
  ];

  List<City> _selectedCities = [];

  TextEditingController _controllerETD = new TextEditingController();
  //TextEditingController _controllerDelay = new TextEditingController();

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Set value of selected cities

    // Set initial display time for time pickers
    _controllerETD.text = "${time.hour}:${time.minute}";

    _controllerETD.addListener(() {
      setState(() {
        String hours = time.hour.toString().padLeft(2, '0');
        String minutes = time.minute.toString().padLeft(2, '0');
        _controllerETD.text = "$hours:$minutes";
      });
    });
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
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors
                            .black), //TODO: Store Text style in a variable to lessen code duplication or change it in main.dart
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
                  Text("From",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  Column(
                    // TODO: Copy this part to have more selectable
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            _cities.length,
                            (index) => GestureDetector(
                                onTap: () =>
                                    setState(() => selectedFrom = index),
                                child: CardWidget(selectedFrom == index,
                                    "${_cities[index].name}")),
                          )),
                    ],
                  ),
                  Text("Via",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  MultiSelectDialogField(
                    items:
                        _cities.map((e) => MultiSelectItem(e, e.name)).toList(),
                    searchable: true,
                    listType: MultiSelectListType.CHIP,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 2),
                    ),
                    itemsTextStyle: TextStyle(color: Colors.white),
                    unselectedColor: Colors.lightBlueAccent,
                    selectedColor: Colors.green,
                    selectedItemsTextStyle: TextStyle(color: Colors.white),
                    buttonText: Text("Select cities"),
                    title: Text("Cities",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    backgroundColor: Colors.white,

                    //selectedItemsTextStyle: TextStyle(color: Colors.green),
                    onConfirm: (values) {
                      _selectedCities = values;
                    },
                  ),
                  Text("From",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  Column(
                    // TODO: Copy this part to have more selectable
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              _cities.length,
                              (index) => GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedTo = index),
                                  child: CardWidget(
                                    selectedTo == index,
                                    "${_cities[index].name}",
                                  )))),
                    ],
                  ),
                  Column( //Start of ETD inputs
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ETD",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                          Text(
                            "Rotor Start",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                          Text(
                            "ATD",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                      if (newTime == null) return;
                                      setState(() => {
                                            time = newTime,
                                          });
                                    }),
                              ),
                            ),
                            Container(
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
                                      if (newTime == null) return;
                                      setState(() => {
                                            time = newTime,
                                          });
                                    }),
                              ),
                            ),
                            Container(
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
                                      if (newTime == null) return;
                                      setState(() => {
                                            time = newTime,
                                          });
                                    }),
                              ),
                            ),
                          ]),
                    ],),
                  Text("Late stuff"),
                  Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: Colors.lightBlue,
                    activeTrackColor: Colors.lightBlueAccent,
                    inactiveThumbColor: Colors.grey[200],
                    inactiveTrackColor: Colors.grey[400],
                  ),
                  if (isSwitched)...[
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                                        if (newTime == null) return;
                                        setState(() => {
                                          time = newTime,
                                        });
                                      }),
                                ),
                              ),
                              Container(
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
                                        if (newTime == null) return;
                                        setState(() => {
                                          time = newTime,
                                        });
                                      }),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ]


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
