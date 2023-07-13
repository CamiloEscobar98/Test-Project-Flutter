class Address {
  int? id;
  final int userId;
  final String address;
  final String neighborhood;

  Address(
      {this.id,
      required this.userId,
      required this.address,
      required this.neighborhood});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'address': address,
      'neighborhood': neighborhood
    };
  }

  Address.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        address = map['address'],
        neighborhood = map['neighborhood'];
}
