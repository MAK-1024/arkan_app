import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/banner_model.dart';

abstract class BannerRemoteDataSource
{
  Future<List<BannerModel>> getBanner();
}

class BannerRemoteDataSourceImpl extends BannerRemoteDataSource
{
  final http.Client client;

  BannerRemoteDataSourceImpl(this.client);


  @override
  Future<List<BannerModel>> getBanner()async {
      final response = await client.get(Uri.parse('https://51.20.185.91/api/v1/banners'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => BannerModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load banners');
    }

  }

}