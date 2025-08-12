import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/register/bloc/register_state.dart';
import '../../../data/models/authTokenModel.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../../domain/useCase/auth_useCase.dart';
import '../../../../../core/erorr/failure.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase registerUserUseCase;
  final SendOtp sendOtpUseCase;

  RegisterCubit(this.registerUserUseCase, this.sendOtpUseCase)
      : super(RegisterInitial());

  String? generatedOtp;
  String? phoneNumber;

  // Step 1: Generate and Send OTP
  Future<void> generateAndSendOTP(String phone) async {
    emit(OTPGenerationLoading());

    try {
      phoneNumber = phone;

      // Generate random OTP
      generatedOtp = (1000 + Random().nextInt(9000)).toString();
      print("Generated OTP: $generatedOtp");

      // Send OTP using use case
      final Either<Failure, void> result =
          await sendOtpUseCase.call(phone, generatedOtp!);

      result.fold(
        (failure) {
          print("OTP sending failure: ${failure.toString()}");
          emit(OTPSendingFailure(errorMessage: failure.toString()));
        },
        (_) {
          print("OTP sent successfully, emitting OTPGenerated");
          emit(OTPGenerated(otp: generatedOtp!));
        },
      );
    } catch (error) {
      print("Exception while sending OTP: $error");
      emit(OTPSendingFailure(errorMessage: error.toString()));
    }
  }

  // Step 2: Verify OTP
  Future<void> verifyOTP(String phone, String enteredOtp, String name,
      String email, String password, String dateOfBirth, int age) async {
    emit(OTPVerificationLoading());

    // Validate the entered OTP
    if (enteredOtp == generatedOtp) {
      print("OTP verified successfully");
      emit(OTPVerified());

      // Proceed with user registration after OTP verification
      await registerUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
        dateOfBirth: dateOfBirth,
        age: age,
      );
    } else {
      print("OTP verification failed");
      emit(OTPVerificationFailed(errorMessage: "رمز التحقق غير صحيح"));
    }
  }

  // Step 3: Register User
  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
    required int age,
  }) async {
    emit(RegistrationLoading());

    final userDetails = UserDetailsEntity(
      name: name,
      email: email,
      phone: phone,
      password: password,
      dateOfBirth: dateOfBirth,
      age: age,
    );

    try {
      print('Name: $name');
      print('Email: $email');
      print('Phone: $phone');
      print('Password: $password');
      print('Date of Birth: $dateOfBirth');
      print('Age: $age');
      final Either<Failure, AuthTokenModel> result =
          await registerUserUseCase.call(userDetails);

      result.fold(
        (failure) {
          print("Exception during registration: $failure");
          print("Registration failure: ${failure.toString()}");
          emit(RegistrationFailure(errorMessage: failure.message.toString()));
        },
        (authToken) {
          print("Registration success, emitting RegistrationSuccess");
          emit(RegistrationSuccess(authToken: authToken));
        },
      );
    } catch (error) {
      print("Exception during registration: $error");
      emit(RegistrationFailure(errorMessage: error.toString()));
    }
  }
}
