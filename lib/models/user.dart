enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  UserType type;
  String? id;
  DateTime? createdAt;

  User({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.type = UserType.PARTICULAR,
    this.id,
    this.createdAt,
  });

  @override
  String toString() {
    return 'User '
        '{name: $name, '
        'phone: $phone,'
        ' email: $email, '
        'password: $password, '
        'type: $type, id: $id, '
        'createdAt: $createdAt}';
  }
}
