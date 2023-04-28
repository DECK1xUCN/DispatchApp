import '../pages/sites.dart';
import 'Site.dart';

class Location {
  int id;
  String name;
  double lat;
  double lon;
  Site site;
  String type;


  Location({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.site,
    required this.type,
  });

  @override
  String toString() {
    return name;
  }
}

