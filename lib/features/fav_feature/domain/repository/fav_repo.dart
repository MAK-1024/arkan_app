import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';


abstract class FavoriteRepository {
  Future<Either<Failure, List<ProductEntity>>> getFavorites(int userId);
  Future<Either<Failure, void>> addFavorite(int userId, int productId);
  Future<Either<Failure, void>> removeFavorite(int userId, int productId);
}
