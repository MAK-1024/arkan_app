import '../../../data/models/authTokenModel.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

// OTP-related states
class OTPGenerationLoading extends RegisterState {}

class OTPGenerated extends RegisterState {
  final String otp;
  OTPGenerated({required this.otp});
}

class OTPSendingFailure extends RegisterState {
  final String errorMessage;
  OTPSendingFailure({required this.errorMessage});
}

class OTPVerificationLoading extends RegisterState {}

class OTPVerified extends RegisterState {}

class OTPVerificationFailed extends RegisterState {
  final String errorMessage;
  OTPVerificationFailed({required this.errorMessage});
}

// Registration-related states
class RegistrationLoading extends RegisterState {}

class RegistrationSuccess extends RegisterState {
  final AuthTokenModel authToken;
  RegistrationSuccess({required this.authToken});
}

class RegistrationFailure extends RegisterState {
  final String errorMessage;
  RegistrationFailure({required this.errorMessage});
}
