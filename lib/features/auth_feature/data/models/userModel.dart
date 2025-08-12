import 'package:equatable/equatable.dart';

class UserDetailsModel extends Equatable {
  final String dateOfBirth;
  final String email;
  final String name;
  final int age;
  final String password;
  final String phone;

  UserDetailsModel({
    required this.dateOfBirth,
    required this.email,
    required this.name,
    required this.age,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateOfBirth': dateOfBirth,
      'email': email,
      'name': name,
      'age':age,
      'password': password,
      'phone': phone,
    };
  }

  @override
  List<Object> get props => [ dateOfBirth, email, name,age, password, phone];

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      dateOfBirth: json['dateOfBirth'] ?? '',
      email: json['email']?? '',
      name: json['name']?? '',
      age: json['age']?? 0,
      password: json['password']?? '',
      phone: json['phone']?? '',
    );
  }
}
