import 'package:equatable/equatable.dart';
import '../../../data/models/UserProfileModel.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel userProfile;

  ProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ProfileUpdated extends ProfileState {
  final UserProfileModel updatedProfile;

  ProfileUpdated(this.updatedProfile);

  @override
  List<Object> get props => [updatedProfile];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
