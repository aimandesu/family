class UserModel {
  String username;
  String email;
  String name;
  String password;

  UserModel({
    required this.username,
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'name': name,
        'password': password,
      };
}
