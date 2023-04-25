import 'package:client/classes/FlightSimple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DailyUpdateForm extends HookWidget {
  const DailyUpdateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlightSimple flight =
        ModalRoute.of(context)!.settings.arguments as FlightSimple;

    final formKey = GlobalKey<FormState>();
    final List<String> delayCodes = ["A", "B", "C", "D", "E", "F", "G", "H"];

    final formState = useState({
      'delayCode': 'A',
      'delayReason': '',
    });

    TextEditingController reasonController = TextEditingController(text: formState.value['delayReason']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Update Form for ${flight.flightnumber}"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(300, 50, 300, 0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text('Delay code:', style: TextStyle(fontSize: 16)),
                  DropdownButtonFormField(
                      value: formState.value['delayCode'],
                      icon: const Icon(Icons.arrow_downward),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: delayCodes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {}),
                  const SizedBox(height: 20),
                  const Text('Delay reason:', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                    controller: reasonController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formState.value['delayReason'] = reasonController.text;
                        print(formState.value);
                        print(flight.id);
                      }
                    },
                    child: const Text('Submit'),
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
