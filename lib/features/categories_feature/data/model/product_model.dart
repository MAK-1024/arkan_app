import 'package:arkanstore_app/features/categories_feature/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required int id,
    required String name,
    required String description,
    required double price,
    required double discount,
    required List<PropertyValue> propertyValue,
    required List<PropertyType> propertyTypes,
    required int quantity,
    bool isFavorite = false,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          discount: discount,
          propertyTypes: propertyTypes,
          isFavorite: isFavorite,
          propertyValue: propertyValue,
    quantity: quantity
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      propertyTypes: (json['propertyTypes'] as List<dynamic>?)
              ?.map((typeJson) => PropertyTypeModel.fromJson(typeJson))
              .toList() ??
          [],
      propertyValue: (json['propertyValue'] as List<dynamic>?)
              ?.map((valueJson) => PropertyValueModel.fromJson(valueJson))
              .toList() ??
          [],
      isFavorite: json['isFavorite'] ?? false,
      quantity:  json['qnt']?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'propertyTypes': propertyTypes
              ?.map((propertyType) =>
                  (propertyType as PropertyTypeModel).toJson())
              .toList() ??
          [],
      'propertyValue': propertyValue
              ?.map((propertyValue) =>
                  (propertyValue as PropertyValueModel).toJson())
              .toList() ??
          [],
      'isFavorite': isFavorite,
    };
  }
}

//*******************************************************************************
class PropertyValueModel extends PropertyValue {
  PropertyValueModel({
    required super.id,
    required super.value,
  });

  factory PropertyValueModel.fromJson(Map<String, dynamic> json) {
    return PropertyValueModel(
      id: json['id'] ?? 0,
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}

//*******************************************************************************
class PropertyTypeModel extends PropertyType {
  PropertyTypeModel({
    required super.id,
    required super.name,
    required super.propertyValues,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      propertyValues: (json['propertyValues'] as List<dynamic>?)
              ?.map((valueJson) => PropertyValueModel.fromJson(valueJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'propertyValues': propertyValues
          .map(
              (propertyValue) => (propertyValue as PropertyValueModel).toJson())
          .toList(),
    };
  }
}
