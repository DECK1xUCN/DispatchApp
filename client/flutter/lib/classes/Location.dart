class Location {
  int id;
  String name;

  Location({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
