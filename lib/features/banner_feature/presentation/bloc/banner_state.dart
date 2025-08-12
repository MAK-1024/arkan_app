import 'package:arkanstore_app/features/banner_feature/domain/entity/banner_entity.dart';

abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerEntity> banners;

  BannerLoaded(this.banners);
}

class BannerError extends BannerState {
  final String message;

  BannerError(this.message);
}

class BannerIndexChanged extends BannerState {
  final int index;

  BannerIndexChanged(this.index);
}
