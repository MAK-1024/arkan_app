import 'package:arkanstore_app/features/categories_feature/data/model/category_model.dart';
import 'package:arkanstore_app/features/categories_feature/domain/repository/category_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../dataSource/category_dataSource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(this.categoryRemoteDataSource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final categories = await categoryRemoteDataSource.getCategories();
      return Right(categories);
    } catch (error) {
      return Left(ServerFailure(message: 'Failed to fetch categories: ${error.toString()}'));
    }
  }
}
