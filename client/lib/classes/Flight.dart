import 'package:client/classes/Location.dart';

class Flight {
  int id;
  DateTime? ata;
  DateTime? atd;
  int? blockTime;
  int? cargoPP;
  bool? delay;
  String? delayCode;
  String? delayDesc;
  int? delayMin; // Delay Amount?
  DateTime? eta;
  DateTime etd;
  int? flightTime;
  String flightnumber;
  Location from;
  List<Location> via;
  Location to;
  int? hoistCycles;
  String? notes;
  int? pax;
  int? paxTax;
  DateTime? rotorStart;
  DateTime? rotorStop;


  Flight({
    required this.id,
    this.ata,
    this.atd,
    this.blockTime,
    this.delayCode,
    this.delayDesc,
    this.delayMin,
    this.eta,
    required this.etd,
    this.flightTime,
    required this.flightnumber,
    required this.from,
    required this.via,
    required this.to,
    this.hoistCycles,
    this.notes,
    this.pax,
    this.paxTax,
    this.rotorStart,
    this.rotorStop,
  });
}
