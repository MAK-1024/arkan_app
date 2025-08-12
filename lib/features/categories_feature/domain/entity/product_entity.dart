import 'package:equatable/equatable.dart';

class PropertyValue extends Equatable {
  final int id;
  final String value;

  PropertyValue({
    required this.id,
    required this.value,
  });

  @override
  List<Object?> get props => [id, value];
}

//******************************************************************************

class PropertyType extends Equatable {
  final int id;
  final String name;
  final List<PropertyValue> propertyValues;

  PropertyType({
    required this.id,
    required this.name,
    required this.propertyValues,
  });

  @override
  List<Object?> get props => [id, name, propertyValues];
}

//******************************************************************************

class ProductEntity extends Equatable {
  final int id;
  final String? name;
  final String? description;
  final double? price;
  final double? discount;
  final List<String>? images;
  final List<PropertyType>? propertyTypes;
  final List<PropertyValue>? propertyValue;
  final bool isFavorite;
  final int? quantity;

  ProductEntity(
      {required this.id,
      this.name,
      this.description,
      this.price,
      this.discount,
      this.images,
      this.propertyTypes,
      this.propertyValue,
      this.isFavorite = false,
      this.quantity});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        discount,
        images,
        propertyTypes,
        propertyValue,
        isFavorite,
        quantity
      ];
}
