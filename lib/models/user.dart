class User {
  int? id;
  final String name;
  final String email;
  final String date;

  User({required this.name, required this.email, required this.date});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'date': date};
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        date = map['date'];
}
