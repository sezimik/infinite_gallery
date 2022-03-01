import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_gallery/gallery/gallery.dart';
import 'package:mocktail/mocktail.dart';
import '../../test_helper.dart';


void main() {

  PhotoBloc photoBloc = PhotoBloc();
  LikeCubit likeCubit = LikeCubit();

  setUp(() {
    photoBloc = MockPhotoBloc();
    likeCubit = MockLikeCubit();
    // we need this to prevent exceptions by network image.
    HttpOverrides.global = null;
  });

  group('Tests the page state for three bloc states and list items ', () {

    testWidgets(
        'When the state is initiated for the very first time and the page shows the loading bar.',
        (tester) async {
      when(() => photoBloc.state).thenReturn(const PhotoState());

      await tester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(providers: [
        BlocProvider<PhotoBloc>(create: (context) => photoBloc),
        BlocProvider<LikeCubit>(create: (context) => likeCubit),
      ], child: const Gallery())));

      expect(find.byType(LoaderWidget), findsNWidgets(1));
    });

    testWidgets(
        'When the API requst is successful and the bloc provides a list of photos to be shown.',
        (tester) async {

               when(()=> likeCubit.state).thenReturn([0,1,3]);

      when(() => photoBloc.state).thenReturn(
            PhotoState(requestStatus: PhotoRequestStatus.success, 
          completed: false,
          photoList: TestHelper().photoListGen(10)
          
          ));

      await tester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(providers: [
        BlocProvider<PhotoBloc>(create: (context) => photoBloc),
        BlocProvider<LikeCubit>(create: (context) => likeCubit),
      ], child: const Gallery())));

      expect(find.byType(PhotoListView), findsNWidgets(1));
    });

    testWidgets(
        'When ther is an error / exception.',
        (tester) async {

               when(()=> likeCubit.state).thenReturn([0,1,3]);

      when(() => photoBloc.state).thenReturn(
          const   PhotoState(requestStatus: PhotoRequestStatus.error, 
          completed: false,
          photoList:[]
          
          ));

      await tester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(providers: [
        BlocProvider<PhotoBloc>(create: (context) => photoBloc),
        BlocProvider<LikeCubit>(create: (context) => likeCubit),
      ], child: const Gallery())));

      expect(find.byType(ErrorDisplayWidget), findsNWidgets(1));
    });
  });

}
