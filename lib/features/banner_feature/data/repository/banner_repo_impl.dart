import 'package:dartz/dartz.dart';
import '../../../../core/erorr/failure.dart';
import '../../domain/entity/banner_entity.dart';
import '../../domain/repository/banner_repo.dart';
import '../dataScourse/banner_dataSource.dart';


class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async {
    try {
      final banners = await remoteDataSource.getBanner();
      return Right(banners);
    } catch (e) {
      return Left(ServerFailure( message: 'Failed to fetch banners.',));
    }
  }
}
