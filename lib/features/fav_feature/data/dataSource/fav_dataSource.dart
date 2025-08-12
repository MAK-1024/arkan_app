import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/erorr/failure.dart';
import '../../../categories_feature/data/model/product_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<ProductModel>> getFavorites(int userId);
  Future<void> addFavorite(int userId, int productId);
  Future<void> removeFavorite(int userId, int productId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final http.Client client;

  FavoriteRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getFavorites(int userId) async {
    final url = Uri.parse('https://51.20.185.91/api/v1/favorites/$userId/favorites');

    try {
      final response = await client.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        // Check for correct format
        if (jsonResponse is! List) {
          throw ServerFailure(message: 'Invalid response format');
        }

        // Map JSON to ProductModel
        return jsonResponse.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        final errorBody = json.decode(response.body) as Map<String, dynamic>;
        throw ServerFailure(message: 'Failed to load favorites: ${errorBody['message']}');
      }
    } catch (error) {
      throw ServerFailure(message: 'Error loading favorites: ${error.toString()}');
    }
  }

  @override
  Future<void> addFavorite(int userId, int productId) async {
    final url = Uri.parse('https://51.20.185.91/api/v1/favorites/$userId/favorites/$productId');

    try {
      final response = await client.post(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        final errorBody = json.decode(response.body) as Map<String, dynamic>;
        throw ServerFailure(message: 'Failed to add favorite: ${errorBody['message']}');
      }
    } catch (error) {
      throw ServerFailure(message: 'Error adding favorite: ${error.toString()}');
    }
  }

  @override
  Future<void> removeFavorite(int userId, int productId) async {
    final url = Uri.parse('https://51.20.185.91/api/v1/favorites/$userId/favorites/$productId');

    try {
      final response = await client.delete(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        final errorBody = json.decode(response.body) as Map<String, dynamic>;
        throw ServerFailure(message: 'Failed to remove favorite: ${errorBody['message']}');
      }
    } catch (error) {
      throw ServerFailure(message: 'Error removing favorite: ${error.toString()}');
    }
  }
}
