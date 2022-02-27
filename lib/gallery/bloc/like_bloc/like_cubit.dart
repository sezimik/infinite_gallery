
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';

class LikeCubit extends Cubit<List<int>> {
  LikeCubit() : super([]);

//fetches liked model from the database
  void loadLikes() async {
      // TODO: implement loading
    emit(tempList);
  }

  ///saves the liked model in the database
  void like(PhotoModel model) async {
    final List<int> tempList = List.from(state);
    tempList.add(model.id);
    emit(tempList);
       // TODO: implement like submit
  }

///deletes the unliked model from the database
  void unLike(PhotoModel model) async {
    final List<int> tempList = List.from(state);
    tempList.remove(model.id);
    emit(tempList);
   // TODO: implement unlike submit
  }

}
