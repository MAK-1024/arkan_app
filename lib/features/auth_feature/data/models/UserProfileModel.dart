import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String name;
  final String email;
  final String? phone;
  final String? password;
  final int? age;
  final String? dateOfBirth;

  UserProfileModel({
    required this.name,
    required this.email,
    this.phone,
    this.password,
    this.age,
    this.dateOfBirth,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'] is String ? json['name'] : '',
      email: json['email'] is String ? json['email'] : '',
      phone: json['phone'] is String ? json['phone'] : null,
      password: json['password'] is String ? json['password'] : null,
      age: json['age'] is int ? json['age'] : null,
      dateOfBirth: json['dateOfBirth'] is String ? json['dateOfBirth'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'age': age,
      'dateOfBirth': dateOfBirth,
    };
  }

  UserProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    int? age,
    String? dateOfBirth,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      age: age ?? this.age,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, password, age, dateOfBirth];
}
