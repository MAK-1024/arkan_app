
import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(int productId, int quantity);
  Future<Either<Failure, void>> updateCart(int productId, int quantity);
  Future<Either<Failure, List<ProductEntity>>> getCartProducts();
}
