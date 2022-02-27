
import 'package:hive/hive.dart';
import '../models/models.dart';
import '../../config/config.dart';

abstract class HiveImplementation {
 Future<void> putHiveModel({required PhotoModel model});
 Future<void> deleteHiveKey({required PhotoModel model});
List<int> getHiveKeys();
}

class HiveServices extends HiveImplementation{
  @override
  Future<void> putHiveModel({required PhotoModel model}) async {
    await Hive.box<PhotoModel>(kHiveBox).put(model.id, model);
  }

  @override
  Future<void> deleteHiveKey({required PhotoModel model}) async {
    await Hive.box<PhotoModel>(kHiveBox).delete(model.id);
  }


  @override
  List<int> getHiveKeys() {
    List<int> _keys =  Hive.box<PhotoModel>("likeBox").keys.toList().cast<int>();
    return _keys;
  }
}