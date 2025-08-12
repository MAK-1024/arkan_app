import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Define the states
abstract class AddressState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Map<String, dynamic>> addresses;

  AddressLoaded(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class AddressSuccess extends AddressState {
  final Map<String, dynamic> address;

  AddressSuccess(this.address);

  @override
  List<Object> get props => [address];
}

class AddressUpdated extends AddressState {
  final Map<String, dynamic> updatedAddress;

  AddressUpdated(this.updatedAddress);

  @override
  List<Object> get props => [updatedAddress];
}

class AddressDeleted extends AddressState {
  final String addressId;

  AddressDeleted(this.addressId);

  @override
  List<Object> get props => [addressId];
}

class AddressError extends AddressState {
  final String message;

  AddressError(this.message);

  @override
  List<Object> get props => [message];
}

class AddressPermissionStatus extends AddressState {
  final bool granted;

  AddressPermissionStatus(this.granted);

  @override
  List<Object> get props => [granted];
}