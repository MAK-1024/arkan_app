import 'package:equatable/equatable.dart';

import '../../../categories_feature/domain/entity/product_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

// Initial State
class FavoriteInitial extends FavoriteState {}

// Loading State
class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductEntity> favorites;

  const FavoriteLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

// Error State
class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}

// Success for adding or removing a favorite
class FavoriteActionSuccess extends FavoriteState {
  final String message;

  const FavoriteActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
