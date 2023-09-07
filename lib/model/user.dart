class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.token,
      required this.type});
}
