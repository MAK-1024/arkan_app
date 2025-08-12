import 'package:arkanstore_app/features/categories_feature/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();

}
