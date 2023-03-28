import 'package:flutter/material.dart';

class FlightForm extends StatefulWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  State<FlightForm> createState() => _FlightFormState();
}

class _FlightFormState extends State<FlightForm> {
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  int id = 1;
  int sitesCount = 5;
  int selectedFrom = -1;
  //String textToDisplay = "${time.hour}:${time.minute}";

  TextEditingController _controllerETD = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerETD.addListener(() {
      setState(() {
        String hours = time.hour.toString().padLeft(2, '0');
        String minutes = time.minute.toString().padLeft(2, '0');
        _controllerETD.text = "$hours:$minutes";
      });
    });
  }

  Widget? createCards(int num) {
    for (int i = 0; i < num; i++) {
      return CardWidget(false, i as String);
    }
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
                  const Text("From",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  Column(
                    // TODO: Copy this part to have more selectable
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            sitesCount,
                            (index) => GestureDetector(
                                onTap: () =>
                                    setState(() => selectedFrom = index),
                                child: CardWidget(
                                    selectedFrom == index, '$index')),
                          )),
                    ],
                  ),
                  Column(
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
                      Row(children: [
                        Container(
                          width: 150,
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
                                  );

                                  if(newTime == null) return;
                                  setState(() => {
                                    time = newTime,
                                  });

                                }),
                          ),
                        ),
                      ]),
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
      width: 50,
      height: 30,
      decoration: BoxDecoration(
        border:
            Border.all(color: selected ? Colors.lightBlueAccent : Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
            index), //TODO: Edit text (strangely enough index is a string by default)
      ),
    );
  }
}
