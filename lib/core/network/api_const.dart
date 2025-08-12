class ApiConst
{
  static const String baseUrl = 'https://51.20.185.91/api/v1';

  static const String iSendUrl = 'https://isend.com.ly/api/v3/sms';


  static String sendOtpEndpoint = '$iSendUrl/send';

  static const String iSendApiKey = 'Bearer 150|KJBHDX9oaioy2fXAvABDQxNkMx9NSKUfB31edRMG';

  static const String loginEndpoint = '$baseUrl/auth/authenticate';

  static const String registerEndpoint = '$baseUrl/auth/register';

  static const String userProfile = '$baseUrl/users';

















  static String getMoviesDetailsPath(int movieId) =>
      '$baseUrl/movie/$movieId';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}