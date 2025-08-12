import 'package:arkanstore_app/features/categories_feature/domain/entity/product_entity.dart';


abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasMore;

  ProductLoaded({required this.products, required this.hasMore});
}

class ProductLoadingMore extends ProductState {
  final List<ProductEntity> products;
  final bool hasMore;

  ProductLoadingMore({required this.products, required this.hasMore});
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
