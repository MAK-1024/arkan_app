import 'package:arkanstore_app/features/categories_feature/data/model/product_model.dart';
import 'package:arkanstore_app/features/categories_feature/domain/repository/product_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../dataSource/product_dataSource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getProductById(int categoryId, int page) async {
    try {
      final productModels = await productRemoteDataSource.getProductsByCategoryId(categoryId, page);
      return Right(productModels);
    } catch (error) {
      return Left(ServerFailure(message: 'Failed to fetch products: ${error.toString()}'));
    }
  }
}
