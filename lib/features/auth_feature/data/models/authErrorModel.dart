class AuthErrorModel {
  final List<String> errors;
  final String message;
  final int status;

  AuthErrorModel({
    required this.errors,
    required this.message,
    required this.status,
  });

  factory AuthErrorModel.fromJson(Map<String, dynamic> json) {
    return AuthErrorModel(
      errors: List<String>.from(json['error'] ?? []),
      message: json['message'] ?? 'Unknown error',
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'message': message,
      'status': status,
    };
  }
}