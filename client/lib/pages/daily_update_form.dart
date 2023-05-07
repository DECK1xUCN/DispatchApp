import 'package:client/classes/flight_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:client/classes/delay_code.dart';
import 'package:graphql_flutter/graphql_flutter.dart'; // This is the enum for the delay codes

class DailyUpdateForm extends HookWidget {
  const DailyUpdateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlightSimple flight =
        ModalRoute.of(context)!.settings.arguments as FlightSimple;

    String updateMutation = """
mutation MyMutation(\$flightId: Int!, \$delay: Boolean!, \$baseAndEquipment: Boolean!, \$maintenance: Boolean!, \$wasFlight: Boolean = false, \$delayCode: String!, \$delayDesc: String!) {
  createDailyUpdate(
    input: {flightId: \$flightId, delay: \$delay, wasFlight: \$wasFlight, maintenance: \$maintenance, baseAndEquipment: \$baseAndEquipment, delayDesc: \$delayDesc, delayCode: \$delayCode}
  ) {
    wasFlight
    delayCode
    delayDesc
    flight {
      id
    }
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
      'cancellationCode': delayCodes.first,
      'cancellationDescription': '',
    });

    TextEditingController cancellationDescriptionController =
        TextEditingController();

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
                  const Text('Cancellation code:',
                      style: TextStyle(fontSize: 16)),
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
                        formState.value['cancellationCode'] = value!;
                      },
                      items: DelayCode.values
                          .map<DropdownMenuItem<DelayCode>>((DelayCode value) {
                        return DropdownMenuItem<DelayCode>(
                          value: value,
                          child: Text(value
                              .toString()
                              .split('.')
                              .last
                              .replaceAll('_', ' ')),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Cancellation description:',
                      style: TextStyle(fontSize: 16)),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                    controller: cancellationDescriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formState.value['cancellationDescription'] =
                            cancellationDescriptionController.text;

                        readMutation.runMutation({
                          'flightId': flight.id,
                          'delayDesc':
                              formState.value['cancellationDescription'],
                          'delayCode': formState.value['cancellationCode']
                              .toString()
                              .split('.')
                              .last,
                          'delay': false,
                          'baseAndEquipment': false,
                          'maintenance': false,
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
