class UF {
  final int id;
  final String initials;
  final String name;

  UF({required this.id, required this.initials, required this.name});

  factory UF.fromJson(Map<String, dynamic> json) => UF(
        id: json['id'],
        initials: json['sigla'],
        name: json['nome'],
      );

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name,}';
  }
}
