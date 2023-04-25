import 'package:client/classes/Location.dart';

import 'DailyUpdate.dart';

class FlightSimple {
  int id;
  DateTime etd;
  String flightnumber;
  Location from;
  Location to;
  bool hasDU;

  FlightSimple({
    required this.id,
    required this.etd,
    required this.flightnumber,
    required this.from,
    required this.to,
    this.hasDU = false,
  });
}