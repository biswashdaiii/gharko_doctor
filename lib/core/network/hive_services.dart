import 'package:gharko_doctor/features/authentication/data/model/user_hive_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveServices {
  Future <void> init()async{
    var directory=await getApplicationDocumentsDirectory();
    var path='${directory.path}gharko_doctor.db';

    Hive.init(path);

  //Register Adapters
  Hive.registerAdapter(UserHiveModelAdapter());
  }
   static Future<Box>openBox(String userBoxName)async{
    return await Hive.openBox(userBoxName);
    }
}