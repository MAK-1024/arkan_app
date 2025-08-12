import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:arkanstore_app/features/auth_feature/data/models/authTokenModel.dart';
import 'package:arkanstore_app/features/auth_feature/domain/useCase/auth_useCase.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/login/bloc/login_state.dart';

import '../../../../../core/helpers/SharedPrefsHelper.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase loginUserUseCase;
  final SharedPrefsHelper _sharedPrefsHelper = SharedPrefsHelper();

  LoginCubit(this.loginUserUseCase) : super(LoginInitial());

  Future<void> login(String phone, String password) async {
    emit(LoginLoading());
    final result = await loginUserUseCase.call(phone, password);
    result.fold(
          (failure) {
        print('Login failure: $failure');
        emit(LoginError(failure.message));
      },
          (authTokenModel) async {
        if (authTokenModel is AuthTokenModel) {
          final String authToken = authTokenModel.token;
          print('Login success: $authToken');

          await _sharedPrefsHelper.saveToken(authToken);

          try {
            final Map<String, dynamic> decodedToken = Jwt.parseJwt(authToken);
            final int? userId = decodedToken['userId'] as int?;

            print('Decoded Token: $decodedToken');
            print(userId);

            if (userId == null) {
              throw Exception('User ID not found in token');
            }

            // Save the user ID using the helper
            await _sharedPrefsHelper.saveUserId(userId);

            emit(LoginSuccess(authTokenModel));
          } catch (e) {
            print('Error decoding token: $e');
            emit(LoginError('Invalid token format'));
          }
        } else {
          emit(LoginError('Unexpected response type'));
        }
      },
    );
  }

  Future<void> logout() async {
    await _sharedPrefsHelper.clearAuthData();
    emit(LoginInitial());
  }
}
