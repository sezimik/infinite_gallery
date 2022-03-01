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

  testWidgets(
      'When 10 photos ae provided by Photobloc and three of them are liked by the user.',
      (tester) async {
    when(() => likeCubit.state).thenReturn([1, 2, 3]);
    when(() => photoBloc.state).thenReturn(PhotoState(
        requestStatus: PhotoRequestStatus.success,
        completed: false,
        photoList: TestHelper().photoListGen(10)));

    await tester.pumpWidget(MaterialApp(
        home: MultiBlocProvider(providers: [
      BlocProvider<PhotoBloc>(create: (context) => photoBloc),
      BlocProvider<LikeCubit>(create: (context) => likeCubit),
    ], child: const Gallery())));

    expect(find.byIcon(Icons.favorite), findsNWidgets(3));
  });
}
