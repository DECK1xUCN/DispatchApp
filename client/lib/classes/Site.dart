

class Site {
  int id;
  String name;

  Site({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
