import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../classes/Flight.dart';

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
  final _formKey = GlobalKey<FormState>();

  TimeOfDay timeETA =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  int id = 1;
  bool isSwitched = false;
  int sitesCount = 5;

  // Dat for the From and To Sites
  int selectedFrom = -1;
  int selectedTo = -1;

  static final List<City> _cities = [
    City(id: 0, name: "Aalborg"),
    City(id: 1, name: "Copenhagen"),
    City(id: 2, name: "London"),
    City(id: 3, name: "Dublin")
  ];

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
  List<City> _selectedCities = [];

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
  final TextEditingController _controllerDelayDescription =
      TextEditingController();
  final TextEditingController _controllerPAX = TextEditingController();
  final TextEditingController _controllerPAXTax = TextEditingController();
  final TextEditingController _controllerCargo = TextEditingController();
  final TextEditingController _controllerHoistCycles = TextEditingController();

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  void setTime(TextEditingController controller, TimeOfDay newTime) {
    controller.addListener(() {
      setState(() {
        String hours = newTime.hour.toString().padLeft(2, '0');
        String minutes = newTime.minute.toString().padLeft(2, '0');
        controller.text = "$hours:$minutes";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Set initial display time for time pickers
    _controllerETD.text = "${time.hour}:${time.minute}";
    _controllerRotorStart.text = _controllerETD.text;
    _controllerATD.text = _controllerETD.text;
    _controllerETA.text = "${time.hour + 1}:${time.minute}";
    _controllerRotorStop.text = _controllerETA.text;
    _controllerATA.text = _controllerETA.text;
  }

  @override
  Widget build(BuildContext context) {
    Flight flight = ModalRoute.of(context)!.settings.arguments as Flight;

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
                  Text("From", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      _cities.length,
                      (index) => GestureDetector(
                          onTap: () => setState(() => selectedFrom = index),
                          child: CardWidget(
                              selectedFrom == index, _cities[index].name)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Via", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  MultiSelectDialogField(
                    items:
                        _cities.map((e) => MultiSelectItem(e, e.name)).toList(),
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
                    buttonText: const Text("Select cities"),
                    title: Text("Cities",
                        style: Theme.of(context).textTheme.titleLarge),
                    backgroundColor: Colors.white,

                    //selectedItemsTextStyle: TextStyle(color: Colors.green),
                    onConfirm: (values) {
                      _selectedCities = values;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text("To", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
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
                                      _controllerETD.text = "$hours:$minutes";
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
                                  controller: _controllerRotorStart,
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
                                  controller: _controllerATD,
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
                                      _controllerATD.text = "$hours:$minutes";
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
                                  controller: _controllerETA,
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
                                      _controllerETA.text = "$hours:$minutes";
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
                                  controller: _controllerRotorStop,
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
                                  controller: _controllerATA,
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
                                      _controllerATA.text = "$hours:$minutes";
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
                                  controller: _controllerBlockTime,
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
                                  controller: _controllerFlightTime,
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
                                    controller: _controllerDelayAmount,
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
                                controller: _controllerDelayReason,
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
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(index),
      ),
    );
  }
}
