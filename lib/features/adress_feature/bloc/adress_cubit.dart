import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import '../../../core/helpers/SharedPrefsHelper.dart';
import 'adress_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  // Retrieve User ID
  Future<int?> getUserId() async {
    return await SharedPrefsHelper().getUserId();
  }

  // Load Addresses for the logged-in user
  Future<void> loadAddresses() async {
    emit(AddressLoading());
    try {
      final userId = await getUserId();
      if (userId != null) {
        List<Map<String, dynamic>> addresses = await SharedPrefsHelper().getAddressList(userId);
        emit(AddressLoaded(addresses));
      } else {
        emit(AddressError('User ID not found'));
      }
    } catch (e) {
      emit(AddressError('Failed to load addresses: ${e.toString()}'));
    }
  }

  // Save a new address
  Future<void> saveAddress(Map<String, dynamic> address) async {
    emit(AddressLoading());
    try {
      final userId = await getUserId();
      if (userId != null) {
        List<Map<String, dynamic>> addresses = await SharedPrefsHelper().getAddressList(userId);

        // Generate a unique ID for the new address
        final String addressId = Uuid().v4(); // Using UUID for unique ID
        address['id'] = addressId; // Add ID to address

        addresses.add(address);
        await SharedPrefsHelper().saveAddressList(userId, addresses);
        emit(AddressSuccess(address));
        emit(AddressLoaded(addresses)); // Emit loaded state again
      } else {
        emit(AddressError('User ID not found'));
      }
    } catch (e) {
      emit(AddressError('Failed to save address: ${e.toString()}'));
    }
  }

  // Update an existing address
  Future<void> updateAddress(Map<String, dynamic> updatedAddress) async {
    emit(AddressLoading());
    try {
      final userId = await getUserId();
      if (userId != null) {
        List<Map<String, dynamic>> addresses = await SharedPrefsHelper().getAddressList(userId);
        int index = addresses.indexWhere((address) => address['id'] == updatedAddress['id']);
        if (index != -1) {
          addresses[index] = updatedAddress; // Update the address
          await SharedPrefsHelper().saveAddressList(userId, addresses);
          emit(AddressUpdated(updatedAddress));
          emit(AddressLoaded(addresses)); // Emit the updated list
        } else {
          emit(AddressError('Address not found'));
        }
      } else {
        emit(AddressError('User ID not found'));
      }
    } catch (e) {
      emit(AddressError('Failed to update address: ${e.toString()}'));
    }
  }

  // Delete an address
  Future<void> deleteAddress(String addressId) async {
    emit(AddressLoading());
    try {
      final userId = await getUserId();
      if (userId != null) {
        List<Map<String, dynamic>> addresses = await SharedPrefsHelper().getAddressList(userId);
        addresses.removeWhere((address) => address['id'] == addressId);
        await SharedPrefsHelper().saveAddressList(userId, addresses);
        // emit(AddressDeleted(addressId));
        emit(AddressLoaded(addresses)); //
      } else {
        emit(AddressError('User ID not found'));
      }
    } catch (e) {
      emit(AddressError('Failed to delete address: ${e.toString()}'));
    }
  }

  // Get the current location
  Future<void> getCurrentLocation() async {
    emit(AddressLoading());

    // Check if GPS is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(AddressError('GPS is not enabled'));
      return;
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        emit(AddressError('Location permission denied'));
        return;
      } else {
        emit(AddressPermissionStatus(true));
      }
    } else {
      emit(AddressPermissionStatus(true));
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      emit(AddressSuccess({'latitude': position.latitude, 'longitude': position.longitude}));
    } catch (e) {
      emit(AddressError('Failed to get location: ${e.toString()}'));
    }
  }
}