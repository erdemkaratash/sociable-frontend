import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  final String id;
  final String username;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(json['token']);
    final Map<String, dynamic> userPayload = decodedToken['user'];

    return User(
      id: userPayload['id'],
      username: json['username'],
      token: json['token'],
    );
}

}
