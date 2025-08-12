import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';
import '../entity/product_entity.dart';

abstract class ProductRepository
{
  Future<Either<Failure, List<ProductEntity>>> getProductById(int categoryId , int page);

}