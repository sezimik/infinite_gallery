
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';
import '../../services/services.dart';

class LikeCubit extends Cubit<List<int>> {
  final _hive =  HiveServices();
  LikeCubit() : super([]);

//fetches liked model from the database
  void loadLikes() async {
    final List<int> tempList =_hive.getHiveKeys();
    emit(tempList);
  }

  ///saves the liked model in the database
  void like(PhotoModel model) async {
    final List<int> tempList = List.from(state);
    tempList.add(model.id);
    emit(tempList);
     await _hive.putHiveModel(model:model);
  }

///deletes the unliked model from the database
  void unLike(PhotoModel model) async {
    final List<int> tempList = List.from(state);
    tempList.remove(model.id);
    emit(tempList);
    await _hive.deleteHiveKey(model:model);
  }

}
