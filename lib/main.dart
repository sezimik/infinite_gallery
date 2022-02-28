import 'package:flutter/material.dart';
import 'package:infinite_gallery/app/app.dart';
import 'package:infinite_gallery/app/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_gallery/config/config.dart';
import 'package:infinite_gallery/gallery/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  await Hive.openBox<PhotoModel>(kHiveBox);

  BlocOverrides.runZoned(() => runApp(const App()),
      blocObserver: MyBlocObserver());
}
