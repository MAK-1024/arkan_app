import 'dart:convert';
import 'package:arkanstore_app/features/categories_feature/data/model/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl(this.client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await client.get(
        Uri.parse('https://51.20.185.91/api/v1/categories'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        return jsonResponse
            .map((categoryJson) => CategoryModel.fromJson(categoryJson))
            .toList();
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception('Failed to fetch categories: ${errorBody['message']}');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}
