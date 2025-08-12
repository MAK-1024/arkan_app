import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arkanstore_app/features/banner_feature/presentation/bloc/banner_state.dart';

import '../../../../core/erorr/failure.dart';
import '../../domain/usacase/banner_usecase.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannersUseCase getBannersUseCase;

  BannerCubit(this.getBannersUseCase) : super(BannerInitial()) {
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    emit(BannerLoading());

    final result = await getBannersUseCase();
    result.fold(
          (failure) => emit(BannerError(_mapFailureToMessage(failure))),
          (banners) => emit(BannerLoaded(banners)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'An unexpected error occurred';
  }
}
