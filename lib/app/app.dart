import 'package:flutter/material.dart';
import '../config/config.dart';
import 'package:infinite_gallery/gallery/screens/gallery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../gallery/bloc/bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: InfiniteColors.blue,
          backgroundColor: InfiniteColors.lightBackground,
          splashColor: InfiniteColors.transparent,
            // primarySwatch: Colors.blue,
            ),
        home: MultiBlocProvider(providers: [
          BlocProvider<PhotoBloc>(create: (context) => PhotoBloc()),
          BlocProvider<LikeCubit>(create: (context) => LikeCubit()),
        ], child: const Gallery()));
  }
}
