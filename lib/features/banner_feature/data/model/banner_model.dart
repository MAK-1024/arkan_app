import '../../domain/entity/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel(
      {required super.id, required super.destination });



  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      destination: json['destination'],
      // imageUrl: json['imageUrl'],
    );
  }
}
