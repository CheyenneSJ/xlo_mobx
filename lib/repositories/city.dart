class City {
  final int? id;
  final String name;

  City({
    this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
      );

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
