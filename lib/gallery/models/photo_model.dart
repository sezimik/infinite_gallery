/*
API structure:
[
  {
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  },
 ...]
 */

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'photo_model.g.dart';

@HiveType(typeId: 0)
class PhotoModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int albumId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;

  const PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        albumId: json["albumId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        url: json["url"] ?? "",
        thumbnailUrl: json["thumbnailUrl"] ?? "");
  }

  @override
  List<Object?> get props => [
    albumId,
        id,
        title,
        url,
        thumbnailUrl,
      ];
}
