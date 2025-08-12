import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';
import '../repository/cart_repo.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<Either<Failure, void>> call(int productId, int quantity) async {
    return await repository.addToCart(productId, quantity);
  }
}


class UpdateCart {
  final CartRepository repository;

  UpdateCart(this.repository);

  Future<Either<Failure, void>> call(int productId, int quantity) async {
    return await repository.updateCart(productId, quantity);
  }
}


class GetCartProducts {
  final CartRepository repository;

  GetCartProducts(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getCartProducts();
  }
}
