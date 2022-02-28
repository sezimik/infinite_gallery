import 'package:flutter_bloc/flutter_bloc.dart';
class MyBlocObserver extends BlocObserver {
  @override
    // ignore: unnecessary_overrides
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
    // ignore: unnecessary_overrides
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
    // ignore: unnecessary_overrides
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  // ignore: unnecessary_overrides
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}