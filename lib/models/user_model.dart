class User {
  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String updatedAt;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
