import 'package:arkanstore_app/features/categories_feature/presentation/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/erorr/failure.dart';
import '../../../domain/useCase/product_usecase.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetCategoryByIdUseCase getCategoryByIdUseCase;
  int _currentPage = 1;
  final int _productsPerPage = 10;
  bool _hasMore = true;

  ProductCubit(this.getCategoryByIdUseCase) : super(ProductInitial());

  Future<void> fetchProductsByCategory(int categoryId) async {
    _resetPagination();

    emit(ProductLoading());
    final result = await getCategoryByIdUseCase.call(categoryId, _currentPage);
    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (products) {
        _hasMore = products.length == _productsPerPage;
        _currentPage++;
        emit(ProductLoaded(products: products, hasMore: _hasMore));
      },
    );
  }

  // Fetch more products for pagination
  Future<void> fetchMoreProductsByCategory(int categoryId) async {
    if (state is ProductLoaded && _hasMore) {
      final currentState = state as ProductLoaded;
      emit(ProductLoadingMore(products: currentState.products, hasMore: _hasMore));

      final result = await getCategoryByIdUseCase.call(categoryId, _currentPage);
      result.fold(
            (failure) => emit(ProductError(_mapFailureToMessage(failure))),
            (newProducts) {
          _hasMore = newProducts.length == _productsPerPage;
          _currentPage++;
          emit(ProductLoaded(
            products: currentState.products + newProducts,
            hasMore: _hasMore,
          ));
        },
      );
    }
  }




  // Reset pagination state
  void _resetPagination() {
    _currentPage = 1;
    _hasMore = true;
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else {
      return 'Unexpected error';
    }
  }
}
