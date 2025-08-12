  import 'package:dartz/dartz.dart';
  import '../../../../core/erorr/failure.dart';
  import '../../../categories_feature/domain/entity/product_entity.dart';
  import '../../domain/repository/fav_repo.dart';
  import '../dataSource/fav_dataSource.dart';

  class FavoriteRepositoryImpl implements FavoriteRepository {
    final FavoriteRemoteDataSource remoteDataSource;

    FavoriteRepositoryImpl({required this.remoteDataSource});

    @override
    Future<Either<Failure, List<ProductEntity>>> getFavorites(int userId) async {
      try {
        final favorites = await remoteDataSource.getFavorites(userId);
        return Right(favorites);
      } catch (error) {
        return Left(ServerFailure(message: 'Failed to fetch favorites: ${error.toString()}'));
      }
    }

    @override
    Future<Either<Failure, void>> addFavorite(int userId, int productId) async {
      try {
        await remoteDataSource.addFavorite(userId, productId);
        return const Right(null);
      } catch (error) {
        return Left(ServerFailure(message: 'Failed to add favorite: ${error.toString()}'));
      }
    }

    @override
    Future<Either<Failure, void>> removeFavorite(int userId, int productId) async {
      try {
        await remoteDataSource.removeFavorite(userId, productId);
        return const Right(null); // Successfully removed, no data to return
      } catch (error) {
        return Left(ServerFailure(message: 'Failed to remove favorite: ${error.toString()}'));
      }
    }
  }
