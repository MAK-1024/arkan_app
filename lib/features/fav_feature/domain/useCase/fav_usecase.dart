import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';
import '../repository/fav_repo.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(int userId) async {
    return await repository.getFavorites(userId);
  }
}

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(int userId, int productId) async {
    try {
      await repository.addFavorite(userId, productId);
      return Right(null);
    } catch (error) {
      return Left(ServerFailure(message: 'Failed to add favorite'));
    }
  }
}

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(int userId, int productId) async {
    try {
      await repository.removeFavorite(userId, productId);
      return Right(null);
    } catch (error) {
      return Left(ServerFailure(message: 'Failed to remove favorite'));
    }
  }
}
