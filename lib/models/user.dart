class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
