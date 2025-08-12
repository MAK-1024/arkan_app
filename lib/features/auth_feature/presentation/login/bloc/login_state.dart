
import '../../../data/models/authTokenModel.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthTokenModel authToken;

  LoginSuccess(this.authToken);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
