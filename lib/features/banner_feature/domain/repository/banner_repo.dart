import 'package:arkanstore_app/features/banner_feature/domain/entity/banner_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/erorr/failure.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<BannerEntity>>> getBanners();
}
