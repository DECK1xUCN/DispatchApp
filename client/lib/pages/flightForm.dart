import 'package:flutter/material.dart';

class FlightForm extends StatefulWidget {
  const FlightForm({Key? key}) : super(key: key);

  @override
  State<FlightForm> createState() => _FlightFormState();
}

class _FlightFormState extends State<FlightForm> {
  int id = 1;
  int sitesCount = 5;
  int selected = -1;

  Widget? createCards(int num) {
    for(int i = 0; i < num; i++){
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
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Flight Number",
                    ),
                    readOnly: true,
                  ),
                  const Text("From",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  Column( // TODO: Copy this part to have more selectable
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          sitesCount,
                          (index) => GestureDetector(
                              onTap: () => setState(() => selected = index),
                              child: CardWidget(selected == index, '$index')
                          ),
                        )
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
      color: selected ? Colors.red : Colors.blue,
      child: Text(index),
    );
  }
}