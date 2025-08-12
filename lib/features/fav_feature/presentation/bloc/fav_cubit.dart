import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../../../core/helpers/SharedPrefsHelper.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';
import '../../domain/useCase/fav_usecase.dart';
import 'fav_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final SharedPrefsHelper sharedPrefsHelper;

  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.sharedPrefsHelper,
  }) : super(FavoriteInitial()) {
    _loadFavoritesFromStorage(); // Load favorites from storage on startup
  }

  List<int> favoriteIds = []; // To keep track of favorite product IDs

  // Load favorites from shared preferences
  Future<void> _loadFavoritesFromStorage() async {
    final userId = await sharedPrefsHelper.getUserId();
    if (userId != null) {
      final Either<Failure, List<ProductEntity>> result =
      await getFavoritesUseCase(userId);
      result.fold(
            (failure) => emit(FavoriteError(_mapFailureToMessage(failure))),
            (favorites) {
          favoriteIds = favorites.map((fav) => fav.id).toList(); // Update favorite IDs
          emit(FavoriteLoaded(favorites)); // Emit loaded state
        },
      );
    }
  }

  // Get the list of favorites
  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final userId = await sharedPrefsHelper.getUserId();
      if (userId == null) {
        emit(FavoriteError('User ID not found in local storage.'));
        return;
      }

      final Either<Failure, List<ProductEntity>> result =
      await getFavoritesUseCase(userId);
      result.fold(
            (failure) => emit(FavoriteError(_mapFailureToMessage(failure))),
            (favorites) {
          favoriteIds = favorites.map((fav) => fav.id).toList(); // Update favorite IDs
          emit(FavoriteLoaded(favorites));
        },
      );
    } catch (e) {
      print('Error: $e');
      emit(FavoriteError('Failed to get favorites.'));
    }
  }

  Future<void> addFavorite(int productId) async {
    emit(FavoriteLoading());
    try {
      final userId = await sharedPrefsHelper.getUserId();
      if (userId == null) {
        emit(FavoriteError('User ID not found in local storage.'));
        return;
      }

      final Either<Failure, void> result =
      await addFavoriteUseCase(userId, productId);
      result.fold(
            (failure) => emit(FavoriteError(_mapFailureToMessage(failure))),
            (_) {
          favoriteIds.add(productId); // Add to the list of favorite IDs
          emit(FavoriteLoaded(favoriteIds.map((id) => ProductEntity(id: id)).toList())); // Emit updated favorites
          emit(FavoriteActionSuccess('Product added to favorites successfully'));
        },
      );
    } catch (e) {
      print('Error: $e');
      emit(FavoriteError('Failed to add product to favorites.'));
    }
  }

  Future<void> removeFavorite(int productId) async {
    emit(FavoriteLoading());
    try {
      final userId = await sharedPrefsHelper.getUserId();
      if (userId == null) {
        emit(FavoriteError('User ID not found in local storage.'));
        return;
      }

      final Either<Failure, void> result =
      await removeFavoriteUseCase(userId, productId);
      result.fold(
            (failure) => emit(FavoriteError(_mapFailureToMessage(failure))),
            (_) {
          favoriteIds.remove(productId); // Remove from the list of favorite IDs
          emit(FavoriteLoaded(favoriteIds.map((id) => ProductEntity(id: id)).toList())); // Emit updated favorites
          emit(FavoriteActionSuccess('Product removed from favorites successfully'));
        },
      );
    } catch (e) {
      print('Error: $e');
      emit(FavoriteError('Failed to remove product from favorites.'));
    }
  }

  // Check if a product is favorite
  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }
}

// Map the failure to a user-friendly message
String _mapFailureToMessage(Failure failure) {
  return failure is ServerFailure ? failure.message : 'Unexpected Error';
}
