import 'package:arkanstore_app/core/erorr/failure.dart';
import 'package:arkanstore_app/features/categories_feature/domain/entity/product_entity.dart';
import 'package:arkanstore_app/features/categories_feature/domain/repository/product_repo.dart';
import 'package:dartz/dartz.dart';

class GetCategoryByIdUseCase
{
 final ProductRepository productRepository;

  GetCategoryByIdUseCase(this.productRepository);

  Future<Either<Failure , List<ProductEntity>>> call(int categoryId , int page)async{
    return await productRepository.getProductById(categoryId , page);
  }
}