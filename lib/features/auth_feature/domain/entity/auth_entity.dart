  import 'package:equatable/equatable.dart';

  class UserDetailsEntity extends Equatable {
    final String name;
    final String email;
    final String phone;
    final int age;
    final String password;
    final String dateOfBirth;

    UserDetailsEntity({
      required this.name,
      required this.email,
      required this.phone,
      required this.age,
      required this.password,
      required this.dateOfBirth,
    });

    @override
    List<Object> get props => [name, email, phone, age , password, dateOfBirth];
  }



  class AuthTokenEntity extends Equatable {
    final String token;

    AuthTokenEntity({required this.token});

    @override
    List<Object> get props => [token];
  }
