import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final int id;
  final String destination;
  // final String imageUrl;

  BannerEntity({
    required this.id,
    required this.destination,
    // required this.imageUrl,
  });

  @override
  List<Object?> get props => [id , destination ];
}
