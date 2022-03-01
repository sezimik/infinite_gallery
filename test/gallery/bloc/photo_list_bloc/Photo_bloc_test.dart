
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_gallery/config/config.dart';
import 'package:infinite_gallery/gallery/bloc/photo_list_bloc/photo_list_bloc.dart';
import 'package:infinite_gallery/gallery/models/photo_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../../../test_helper.dart';


void main() {
  // I changed  http.get(uri) from URI to any() in order focus on the bloc behavior, otherwise we can inject the following URI
  // Uri mockUri(int start) => Uri.http("jsonplaceholder.typicode.com", "/photos", {"_start": "$start", "_limit": "25"});

  // mocked models and their json lists
  const firstMockedModel = [
    PhotoModel(
        albumId: 1,
        id: 1,
        title: "mock photo",
        url: "http://mockUrl",
        thumbnailUrl: "http://mockThumbUrl")
  ];
  const secondMockedModel = [
    PhotoModel(
        albumId: 2,
        id: 2,
        title: "mock photo two",
        url: "http://mockUrl-2",
        thumbnailUrl: "http://mockThumbUrl-2")
  ];

  const firstMockedBody =
      '[{"albumId": 1, "id": 1, "title": "mock photo", "url": "http://mockUrl", "thumbnailUrl":"http://mockThumbUrl"}]';
  const secondMockedBody =
      '[{"albumId": 2, "id": 2, "title": "mock photo two", "url": "http://mockUrl-2", "thumbnailUrl":"http://mockThumbUrl-2"}]';

  group('When PhotoBloc emits various states based on the http request states.', () {
    late http.Client httpClient;

    // creating a new instance for each test
    PhotoBloc _photoBlocMaker() {
      PhotoBloc _bloc = PhotoBloc();
      _bloc.injectMockClient(httpClient);
      return _bloc;
    }

    

    setUpAll(() {
      registerFallbackValue(Uri());
      httpClient = MockClient();
    });



    blocTest<PhotoBloc, PhotoState>(
      'When the photo list is empty and the first http requst is submitted with success.',
      setUp: () {
        when(() => httpClient.get(any())).thenAnswer((_) async {
          return http.Response(firstMockedBody, 200);
        });
      },
      build: () => _photoBlocMaker(),
      seed: () => const PhotoState(photoList: [], completed: false),
      act: (bloc) => bloc.add(const PhotoEventRequest()),
      expect: () => const <PhotoState>[
        PhotoState(
          requestStatus: PhotoRequestStatus.success,
          photoList: firstMockedModel,
          completed: false,
        )
      ],
    );


    blocTest<PhotoBloc, PhotoState>(
      "When the Photo List is NOT empty and the new request was successful.",
      setUp: () {
        when(() => httpClient.get(any())).thenAnswer((_) async {
          return http.Response(
            secondMockedBody,
            200,
          );
        });
      },
      build: () => _photoBlocMaker(),
      seed: () => const PhotoState(
        requestStatus: PhotoRequestStatus.success,
        photoList: firstMockedModel,
        completed: false,
      ),
      act: (bloc) => bloc.add(const PhotoEventRequest()),
      expect: () => const <PhotoState>[
        PhotoState(
          requestStatus: PhotoRequestStatus.success,
          photoList: [...firstMockedModel, ...secondMockedModel],
          completed: false,
        )
      ],
    );

 

    blocTest<PhotoBloc, PhotoState>(
      'When state is not completed but the return response.body is empty which means no more photos and the state should be completed',
      setUp: () {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('[]', 200),
        );
      },
      build: () => _photoBlocMaker(),
      seed: () => const PhotoState(
        requestStatus: PhotoRequestStatus.success,
        photoList: firstMockedModel,
        completed: false,
      ),
      act: (bloc) => bloc.add(const PhotoEventRequest()),
      expect: () => const <PhotoState>[
        PhotoState(
          requestStatus: PhotoRequestStatus.success,
          photoList: firstMockedModel,
          completed: true,
        )
      ],
    );


   blocTest<PhotoBloc, PhotoState>(
      'When http request throws exception and  errorMessage != ""',
      setUp: () {
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('', 404),
        );
      },
      build: () => _photoBlocMaker(),
      act: (bloc) => bloc.add(const PhotoEventRequest()),
      expect: () => const <PhotoState>[
        PhotoState(
          requestStatus: PhotoRequestStatus.error,
          errorMessage: kErrorMessage,
          photoList: [],
          completed: false,
        )
      ],
    );

    blocTest<PhotoBloc, PhotoState>(
      "When any request for fetching photos bounces back because the list is completed/ no more photos.",
      build: () => _photoBlocMaker(),
      seed: () => const PhotoState(completed: true),
      act: (bloc) => bloc.add(const PhotoEventRequest()),
      expect: () => <PhotoState>[],
    );
  });
}






















