class UserModel {
  String userUID;
  String username;
  String email;
  String name;
  String password;
  String token;
  String image;

  UserModel({
    required this.userUID,
    required this.username,
    required this.email,
    required this.name,
    required this.password,
    required this.token,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'userUID': userUID,
        'username': username,
        'email': email,
        'name': name,
        'password': password,
        'token': token,
        'image': image,
      };
}
