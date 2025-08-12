import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/SharedPrefsHelper.dart';
import '../../../data/models/UserProfileModel.dart';
import '../../../domain/useCase/auth_useCase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  ProfileCubit(this.getUserProfileUseCase, this.updateUserProfileUseCase) : super(ProfileInitial());

  Future<String?> getUserId() async {
    // Use SharedPrefsHelper to retrieve user ID
    final SharedPrefsHelper prefsHelper = SharedPrefsHelper();
    return (await prefsHelper.getUserId())?.toString();
  }

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      final userId = await getUserId();

      if (userId != null) {
        final result = await getUserProfileUseCase.call(userId);

        result.fold(
              (failure) {
            print('Error fetching profile: ${failure.message}');
            emit(ProfileError(failure.message));
          },
              (userProfile) => emit(ProfileLoaded(userProfile)),
        );
      } else {
        emit(ProfileError('User ID not found'));
      }
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProfileError('An unexpected error occurred'));
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updatedFields) async {
    emit(ProfileLoading());
    try {
      final userId = await getUserId();

      if (userId != null) {
        final result = await getUserProfileUseCase.call(userId);

        result.fold(
              (failure) {
            print('Error fetching profile for update: ${failure.message}');
            emit(ProfileError(failure.message));
          },
              (currentUserProfile) {
            final updatedProfile = currentUserProfile.copyWith(
              name: updatedFields['name'],
              email: updatedFields['email'],
              phone: updatedFields['phone'],
              password: updatedFields['password'],
              age: updatedFields['age'],
              dateOfBirth: updatedFields['dateOfBirth'],
            );

            updateUserProfileUseCase.call(userId, updatedProfile).then((updateResult) {
              updateResult.fold(
                    (failure) {
                  print('Error updating profile: ${failure.message}');
                  emit(ProfileError(failure.message));
                },
                    (newProfile) => emit(ProfileUpdated(newProfile)),
              );
            });
          },
        );
      } else {
        emit(ProfileError('User ID not found'));
      }
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProfileError('An unexpected error occurred'));
    }
  }

  Future<void> updatePassword(String newPassword) async {
    emit(ProfileLoading());
    try {
      final userId = await getUserId();

      if (userId != null) {
        final result = await getUserProfileUseCase.call(userId);

        result.fold(
              (failure) {
            print('Error fetching profile for password update: ${failure.message}');
            emit(ProfileError(failure.message));
          },
              (currentUserProfile) {
            final updatedProfile = currentUserProfile.copyWith(
              password: newPassword,
            );

            updateUserProfileUseCase.call(userId, updatedProfile).then((updateResult) {
              updateResult.fold(
                    (failure) {
                  print('Error updating password: ${failure.message}');
                  emit(ProfileError(failure.message));
                },
                    (newProfile) => emit(ProfileUpdated(newProfile)),
              );
            });
          },
        );
      } else {
        emit(ProfileError('User ID not found'));
      }
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProfileError('An unexpected error occurred'));
    }
  }
}
