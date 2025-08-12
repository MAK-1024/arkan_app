import 'package:dartz/dartz.dart';
import '../repository/banner_repo.dart';
import '../../../../core/erorr/failure.dart';
import '../entity/banner_entity.dart';

class GetBannersUseCase {
  final BannerRepository bannerRepository;

  GetBannersUseCase(this.bannerRepository);

  Future<Either<Failure, List<BannerEntity>>> call() async {
    return await bannerRepository.getBanners();
  }
}
