import 'package:client/classes/Location.dart';

class Flight {
  DateTime etd;
  String flightnumber;
  Location from;
  Location to;

  Flight({
    required this.etd,
    required this.flightnumber,
    required this.from,
    required this.to,
  });
}
