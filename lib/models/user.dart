class User {
  int? id;
  final String name;
  final String email;
  final String date;

  User({this.id, required this.name, required this.email, required this.date});

  void setId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'date': date};
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        date = map['date'];
}
