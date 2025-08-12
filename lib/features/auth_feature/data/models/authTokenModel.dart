class AuthTokenModel {
  final String token;

  AuthTokenModel({required this.token});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['token'] ?? '',
    );
  }
}
