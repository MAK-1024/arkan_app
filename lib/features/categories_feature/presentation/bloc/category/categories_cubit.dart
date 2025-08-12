import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/useCase/category_usecase.dart';
import 'categories_state.dart';

class CategoryBloc extends Cubit<CategoryState> {
  final GetCategoryUseCase getCategoryUseCase;

  CategoryBloc(this.getCategoryUseCase) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());

    final result = await getCategoryUseCase();

    result.fold(
          (failure) {
        emit(CategoryError(failure.message));
      },
          (categories) {
        emit(CategoryLoaded(categories));
      },
    );
  }
}
