import 'package:client/classes/FlightSimple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:client/classes/delayCode.dart';
import 'package:graphql_flutter/graphql_flutter.dart'; // This is the enum for the delay codes

class DailyUpdateForm extends HookWidget {
  const DailyUpdateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlightSimple flight =
        ModalRoute.of(context)!.settings.arguments as FlightSimple;

    String updateMutation = """
mutation MyMutation(\$flightId: Int!, \$delayCode: String!, \$delayDesc: String!) {
  createDailyUpdate(
    input: {wasFlight: false, flightId: \$flightId, delayCode: \$delayCode, delayDesc: \$delayDesc}
  ) {
    wasFlight
    flight {
      id
    }
    delayCode
    delayDesc
  }
}
    """;

    final readMutation = useMutation(
      MutationOptions(
        document: gql(updateMutation),
      ),
    );

    final formKey = GlobalKey<FormState>();
    DelayCode dropdownValue = DelayCode.A_HeliWeather;

    final formState = useState({
      'cancelationCode': delayCodes.first,
      'cancelationDescription': '',
    });

    TextEditingController cancelationDescriptionController = TextEditingController();


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
                  const Text('Cancelation code:', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    // Delay Reason
                    width: 150,
                    height: 60,
                    child: DropdownButtonFormField<DelayCode>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (DelayCode? value) {
                        // This is called when the user selects an item.
                        formState.value['dropdownValue'] = value!;
                        formState.value = {...formState.value};
                      },
                      items: DelayCode.values
                          .map<DropdownMenuItem<DelayCode>>(
                              (DelayCode value) {
                            return DropdownMenuItem<DelayCode>(
                              value: value,
                              child: Text(
                                  value
                                      .toString()
                                      .split('.')
                                      .last
                                      .replaceAll('_',
                                      ' ')),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Cancellation description:', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                    controller: cancelationDescriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formState.value['cancelationDescription'] = cancelationDescriptionController.text;
                        print(formState.value);
                        print(flight.id);
                        readMutation.runMutation({
                          'flightId': flight.id,
                          'delayDesc': formState.value['cancelationDescription'],
                          'delayCode': formState.value['cancelationCode'].toString().split('.').last,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
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
