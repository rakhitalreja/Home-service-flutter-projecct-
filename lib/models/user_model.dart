class UserModel {
  final String name;
  final String email;
  final String password;

  const UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  UserModel copyWith({String? name, String? email, String? password}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}