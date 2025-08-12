import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../data/models/UserProfileModel.dart';
import '../../data/models/authTokenModel.dart';
import '../entity/auth_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure, AuthTokenModel>> login(String phone, String password);

  Future<Either<Failure, AuthTokenModel>> register(UserDetailsEntity userDetailsEntity);

  Future<Either<Failure, void>> sendOtp(String phoneNumber, String otp);

  Future<Either<Failure, UserProfileModel>> getUserProfile(String userId);

  Future<Either<Failure, UserProfileModel>> updateUserProfile(String userId , UserProfileModel userProfileModel);

}
