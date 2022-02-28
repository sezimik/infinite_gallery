import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'dart:convert';

class PhotoRepository {
  static const baseUrl = "https://jsonplaceholder.typicode.com";
  static const resourceType = "photos";
  static const int querylimit = 25;

  http.Client httpClient = http.Client();

  /// Dependency injection for tests
  PhotoRepository({http.Client? client}) {
    httpClient = client ?? http.Client();
  }

  Future<List<PhotoModel>> fetchPhotos({required int startIndex}) async {
    final String _photoQuertUrl =
        "$baseUrl/$resourceType?_start=$startIndex&_limit=$querylimit";
        
    final _response = await httpClient.get(Uri.parse(_photoQuertUrl));

    if (_response.statusCode == 200) {
      final data = json.decode(_response.body);
      List<PhotoModel> photosList =
          (data as List).map((e) => PhotoModel.fromJson(e)).toList();

      return photosList;
    } else {
      throw Exception("Something went wrong!");
    }
  }
}
