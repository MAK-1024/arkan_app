import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../domain/entity/category_entity.dart';

import '../repository/category_repo.dart';

class GetCategoryUseCase {
  final CategoryRepository categoryRepository;

  GetCategoryUseCase(this.categoryRepository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await categoryRepository.getAllCategories();
  }
}
