import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'ETD',
      field: 'etd',
      type: PlutoColumnType.time(),
      width: 200,
    ),
    PlutoColumn(
      title: 'Flightnumber',
      field: 'flightnumber',
      type: PlutoColumnType.text(),
      width: 100,
    ),
    PlutoColumn(
      title: 'From',
      field: 'from',
      type: PlutoColumnType.text(),
      width: 100,
    ),
    PlutoColumn(
      title: 'Via',
      field: 'via',
      type: PlutoColumnType.text(),
      width: 100,
    ),
    PlutoColumn(
      title: 'To',
      field: 'to',
      type: PlutoColumnType.text(),
      width: 100,
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'etd': PlutoCell(value: DateTime.now()),
        'flightnumber': PlutoCell(value: '1234-A'),
        'from': PlutoCell(value: 'ABC'),
        'via': PlutoCell(value: 'V1'),
        'to': PlutoCell(value: 'DEF'),
      },
    ),
  ];


  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('potential add flight button'),
            Expanded(
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                configuration: const PlutoGridConfiguration(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
