import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/network/api_const.dart';
import '../../models/UserProfileModel.dart';
import '../../models/authTokenModel.dart';
import '../../models/userModel.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login(String phone, String password);

  Future<AuthTokenModel> register(UserDetailsModel userDetails);

  Future<void> sendOtp(String phoneNumber, String otp);

  Future<UserProfileModel> getUserProfile(String userId);

  Future<UserProfileModel> updateUserProfile(
      String userId, UserProfileModel userProfileModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<AuthTokenModel> login(String phone, String password) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConst.loginEndpoint),
        body: jsonEncode({'phone': phone, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return AuthTokenModel.fromJson(jsonDecode(response.body));
      } else {
        final errorBody = jsonDecode(response.body);
        print(errorBody);
        throw Exception('Login failed: ${errorBody['message']}');
      }
    } catch (error) {
      // Log the error
      throw Exception('Login error: $error');
    }
  }

  @override
  Future<AuthTokenModel> register(UserDetailsModel userDetails) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConst.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userDetails.toJson()),
      );

      if (response.statusCode == 201) {
        return AuthTokenModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        print(errorBody);
        throw Exception(' ${errorBody}');
      } else {
        final errorBody = jsonDecode(response.body);
        print(errorBody);
        throw Exception('Registration failed: ${errorBody['message']}');
      }
    } catch (error) {
      throw Exception('Register error: $error');
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber, String otp) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConst.sendOtpEndpoint),
        headers: {
          'Authorization': ApiConst.iSendApiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'recipient': phoneNumber,
          'sender_id': 'iSend',
          'type': 'unicode',
          'message': 'Your OTP is: $otp',
        }),
      );

      if (response.statusCode != 200) {
        final errorBody = jsonDecode(response.body);
        print(errorBody);

        throw Exception('Failed to send OTP: ${errorBody['message']}');
      }
    } catch (error) {
      throw Exception('Error sending OTP: $error');
    }
  }

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiConst.userProfile}/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return UserProfileModel.fromJson(jsonResponse);
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(
            'Failed to fetch user profile: ${errorBody['message']}');
      }
    } catch (error) {
      throw Exception('Error fetching user profile: $error');
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile(
      String userId, UserProfileModel userProfileModel) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiConst.userProfile}/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': userProfileModel.name,
          'email': userProfileModel.email,
          'password': userProfileModel.password,
          'phone': userProfileModel.phone,
          'age': userProfileModel.age,
          'dateOfBirth': userProfileModel.dateOfBirth,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return UserProfileModel.fromJson(jsonResponse);
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(
            'Failed to update user profile: ${errorBody['message']}');
      }
    } catch (error) {
      throw Exception('Error updating user profile: $error');
    }
  }
}
