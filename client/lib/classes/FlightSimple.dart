import 'package:client/classes/location.dart';

class FlightSimple {
  int id;
  DateTime etd;
  String flightnumber;
  Location from;
  Location to;
  int siteId;
  bool hasDU;

  FlightSimple({
    required this.id,
    required this.etd,
    required this.flightnumber,
    required this.from,
    required this.to,
    required this.siteId,
    this.hasDU = false,
  });
}