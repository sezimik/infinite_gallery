import 'package:bloc_test/bloc_test.dart';
import 'package:infinite_gallery/gallery/gallery.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// this class contains helper methods used in test 
class TestHelper {
 List<PhotoModel> photoListGen(int length) {

  return   List.generate(
      length,
      (index) => PhotoModel(
          albumId: 1,
          id: index,
          title: 'Photo #$index',
          url: "https://via.placeholder.com/600/24f355",
          thumbnailUrl: "https://via.placeholder.com/600/24f355"));

  }
}


class MockPhotoBloc extends MockBloc<PhotoEvent, PhotoState>
    implements PhotoBloc {}

class MockLikeCubit extends MockCubit<List<int>> implements LikeCubit {}

class MockClient extends Mock implements http.Client {}