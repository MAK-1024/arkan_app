import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/erorr/failure.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsByCategoryId(int categoryId, int page);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProductsByCategoryId(int categoryId, int page) async {
    final url = Uri.parse('https://51.20.185.91/api/v1/products/filter?categoryId=$categoryId&page=$page');

    try {
      final response = await client.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final productsJson = jsonResponse['content'] as List<dynamic>;

        if (productsJson is! List) {
          throw ServerFailure(message: 'Invalid response format');
        }

        return productsJson.map((productJson) => ProductModel.fromJson(productJson)).toList();
      } else {
        final errorBody = json.decode(response.body) as Map<String, dynamic>;
        throw ServerFailure(message: 'Failed to fetch products: ${errorBody['message']}');
      }
    } catch (error) {
      throw ServerFailure(message: 'Error fetching products: ${error.toString()}');
    }
  }
}
