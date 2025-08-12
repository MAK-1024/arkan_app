  import 'package:arkanstore_app/features/auth_feature/data/models/authTokenModel.dart';
  import 'package:arkanstore_app/features/auth_feature/data/models/userModel.dart';
  import 'package:dartz/dartz.dart';
  import '../../../../core/erorr/failure.dart';
  import '../../data/models/UserProfileModel.dart';
import '../entity/auth_entity.dart';
  import '../repository/auth_repository.dart';


  class LoginUserUseCase {
    final AuthRepository repository;

    LoginUserUseCase(this.repository);

    Future<Either<Failure, AuthTokenModel>> call(String phone, String password) async {
      return await repository.login(phone, password);
    }
  }


  class RegisterUserUseCase {
    final AuthRepository repository;

    RegisterUserUseCase(this.repository);

    Future<Either<Failure, AuthTokenModel>> call(UserDetailsEntity userDetails) async {
      return await repository.register(userDetails);
    }
  }


  class SendOtp {
    final AuthRepository repository;

    SendOtp(this.repository);

    Future<Either<Failure, void>> call(String phoneNumber, String otp) async {
      return await repository.sendOtp(phoneNumber, otp);
    }
  }



  class GetUserProfileUseCase {
    final AuthRepository repository;

    GetUserProfileUseCase(this.repository);

    Future<Either<Failure, UserProfileModel>> call(String userId) async {
      return await repository.getUserProfile(userId);
    }
  }

  class UpdateUserProfileUseCase {
    final AuthRepository repository;

    UpdateUserProfileUseCase(this.repository);

    Future<Either<Failure, UserProfileModel>> call(String userId ,UserProfileModel userProfileModel)  async {
      return await repository.updateUserProfile(userId , userProfileModel);
    }
  }


