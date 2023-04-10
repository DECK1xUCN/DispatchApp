import 'package:client/classes/Location.dart';

class Flight {
  DateTime etd;
  String flightnumber;
  Location from;
  List<Location> via;
  Location to;

  Flight({
    required this.etd,
    required this.flightnumber,
    required this.from,
    required this.via,
    required this.to,
  });

  viaToString(){
    var returnString = '';
    for (var location in via) {
      returnString += '${location.toString()} ';
    }
  }
}