import '../pages/sites.dart';
import 'Site.dart';

class LocationShort {
  int id;
  String name;


  LocationShort({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}

