
/*
Json structure:
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

class PhotoModel extends Equatable {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  const PhotoModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl,});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        albumId: json["albumId"] ?? 0,
        id:  json["id"] ?? 0,
        title: json["title"] ?? "",
        url: json["url"] ?? "",
        thumbnailUrl: json["thumbnailUrl"] ?? "");
  }

  @override
  List<Object?> get props => [
        id,
        title,
        url,
        thumbnailUrl,
      ];
}