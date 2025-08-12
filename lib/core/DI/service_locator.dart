import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:arkanstore_app/features/auth_feature/domain/repository/auth_repository.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/login/bloc/login_cubit.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/register/bloc/register_cubit.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/profile/bloc/profile_cubit.dart';
import 'package:arkanstore_app/features/auth_feature/data/dataSource/remote/AuthRemoteDataSource.dart';
import 'package:arkanstore_app/features/auth_feature/data/repositoty/auth_repo_impl.dart';
import 'package:arkanstore_app/features/auth_feature/domain/useCase/auth_useCase.dart';

import '../../features/banner_feature/data/dataScourse/banner_dataSource.dart';
import '../../features/banner_feature/data/repository/banner_repo_impl.dart';
import '../../features/banner_feature/domain/repository/banner_repo.dart';
import '../../features/banner_feature/domain/usacase/banner_usecase.dart';
import '../../features/banner_feature/presentation/bloc/banner_cubit.dart';
import '../../features/categories_feature/data/dataSource/category_dataSource.dart';
import '../../features/categories_feature/data/dataSource/product_dataSource.dart';
import '../../features/categories_feature/data/repository/category_repo_impl.dart';
import '../../features/categories_feature/data/repository/product_repo_impl.dart';
import '../../features/categories_feature/domain/repository/category_repo.dart';
import '../../features/categories_feature/domain/repository/product_repo.dart';
import '../../features/categories_feature/domain/useCase/category_usecase.dart';
import '../../features/categories_feature/domain/useCase/product_usecase.dart';
import '../../features/categories_feature/presentation/bloc/category/categories_cubit.dart';
import '../../features/categories_feature/presentation/bloc/product/product_cubit.dart';

import '../../features/fav_feature/data/dataSource/fav_dataSource.dart';
import '../../features/fav_feature/data/repositoty/fav_repo_impl.dart';
import '../../features/fav_feature/domain/repository/fav_repo.dart';
import '../../features/fav_feature/domain/useCase/fav_usecase.dart';
import '../../features/fav_feature/presentation/bloc/fav_cubit.dart';

import '../helpers/SharedPrefsHelper.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // Register http client
    sl.registerLazySingleton<http.Client>(() => http.Client());

    // Auth Feature
    sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl<http.Client>()));
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
    sl.registerFactory<LoginUserUseCase>(() => LoginUserUseCase(sl<AuthRepository>()));
    sl.registerFactory<RegisterUserUseCase>(() => RegisterUserUseCase(sl<AuthRepository>()));
    sl.registerFactory<GetUserProfileUseCase>(() => GetUserProfileUseCase(sl<AuthRepository>()));
    sl.registerFactory<UpdateUserProfileUseCase>(() => UpdateUserProfileUseCase(sl<AuthRepository>()));
    sl.registerFactory<SendOtp>(() => SendOtp(sl<AuthRepository>()));
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginUserUseCase>()));
    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl<RegisterUserUseCase>(), sl<SendOtp>()));
    sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl<GetUserProfileUseCase>(), sl<UpdateUserProfileUseCase>()));

    // Category Feature
    sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(sl<http.Client>()));
    sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl<CategoryRemoteDataSource>()));
    sl.registerFactory<GetCategoryUseCase>(() => GetCategoryUseCase(sl<CategoryRepository>()));
    sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl<GetCategoryUseCase>()));

    // Product Feature
    sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(sl<http.Client>()));
    sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl<ProductRemoteDataSource>()));
    sl.registerFactory<GetCategoryByIdUseCase>(() => GetCategoryByIdUseCase(sl<ProductRepository>()));
    sl.registerFactory<ProductCubit>(() => ProductCubit(sl<GetCategoryByIdUseCase>()));

    // Favorite Feature
    sl.registerLazySingleton<FavoriteRemoteDataSource>(() => FavoriteRemoteDataSourceImpl( client: sl<http.Client>(),));
    sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(remoteDataSource: sl<FavoriteRemoteDataSource>()));
    sl.registerFactory<GetFavoritesUseCase>(() => GetFavoritesUseCase(sl<FavoriteRepository>()));
    sl.registerFactory<AddFavoriteUseCase>(() => AddFavoriteUseCase(sl<FavoriteRepository>()));
    sl.registerFactory<RemoveFavoriteUseCase>(() => RemoveFavoriteUseCase(sl<FavoriteRepository>()));
    sl.registerFactory<FavoriteCubit>(() => FavoriteCubit(
      getFavoritesUseCase: sl<GetFavoritesUseCase>(),
      addFavoriteUseCase: sl<AddFavoriteUseCase>(),
      removeFavoriteUseCase: sl<RemoveFavoriteUseCase>(),
      sharedPrefsHelper: sl<SharedPrefsHelper>(),
    ));


// Banner Feature
    sl.registerLazySingleton<BannerRemoteDataSource>(() => BannerRemoteDataSourceImpl(sl<http.Client>()));
    sl.registerLazySingleton<BannerRepository>(() => BannerRepositoryImpl(sl<BannerRemoteDataSource>()));
    sl.registerFactory<GetBannersUseCase>(() => GetBannersUseCase(sl<BannerRepository>()));
    sl.registerFactory<BannerCubit>(() => BannerCubit(sl<GetBannersUseCase>()));


    // Register Shared Preferences
    sl.registerLazySingleton<SharedPrefsHelper>(() => SharedPrefsHelper());
  }
}
