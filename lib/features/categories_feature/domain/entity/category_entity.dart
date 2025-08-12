import 'package:arkanstore_app/features/categories_feature/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;
  final List<PropertyType>? propertyTypes;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.propertyTypes,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, propertyTypes];
}
