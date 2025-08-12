import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSource/remote/AuthRemoteDataSource.dart';
import '../models/UserProfileModel.dart';
import '../models/authTokenModel.dart';
import '../models/userModel.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, AuthTokenModel>> login(String phone, String password) async {
    try {
      final authToken = await authRemoteDataSource.login(phone, password);
      return Right(authToken);
    } catch (error) {
      return Left(ServerFailure(message: 'Login failed: ${error.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthTokenModel>> register(UserDetailsEntity userDetailsModel) async {
    try {
      final userDetails = UserDetailsModel(
        name: userDetailsModel.name,
        email: userDetailsModel.email,
        phone: userDetailsModel.phone,
        password: userDetailsModel.password,
        dateOfBirth: userDetailsModel.dateOfBirth,
        age: userDetailsModel.age,
      );

      final authToken = await authRemoteDataSource.register(userDetails);
      return Right(authToken);
    } catch (error) {
      return Left(ServerFailure(message: 'Registration failed: ${error.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(String phoneNumber, String otp) async {
    try {
      await authRemoteDataSource.sendOtp(phoneNumber, otp);
      return Right(null);
    } catch (error) {
      return Left(ServerFailure(message: 'OTP sending failed: ${error.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile(String userId) async {
    try {
      if (userId.isEmpty) {
        return Left(ServerFailure(message: 'User ID cannot be empty'));
      }
      final userDetails = await authRemoteDataSource.getUserProfile(userId);
      return Right(userDetails);
    } catch (error) {
      // Consider logging the error here
      return Left(ServerFailure(message: 'Failed to fetch user profile: ${error.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateUserProfile(String userId, UserProfileModel userProfileModel) async {
    try {
      if (userId.isEmpty) {
        return Left(ServerFailure(message: 'User ID cannot be empty'));
      }

      final updatedUserProfile = await authRemoteDataSource.updateUserProfile(userId, userProfileModel);

      return Right(updatedUserProfile);
    } catch (error) {
      return Left(ServerFailure(message: 'Failed to update user profile: ${error.toString()}'));
    }
  }

}
