import 'package:arkanstore_app/features/categories_feature/data/model/product_model.dart';
import 'package:arkanstore_app/features/categories_feature/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  final List<PropertyTypeModel> propertyTypes;

  CategoryModel({
    required int id,
    required String name,
    required String imageUrl,
    required this.propertyTypes,
  }) : super(id: id, name: name, imageUrl: imageUrl, propertyTypes: propertyTypes);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var propertyTypesJson = json['propertyTypes'] as List<dynamic>? ?? [];
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['photo'] ?? '',
      propertyTypes: propertyTypesJson
          .map((typeJson) => PropertyTypeModel.fromJson(typeJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': imageUrl,
      'propertyTypes': propertyTypes.map((type) => type.toJson()).toList(),
    };
  }
}
