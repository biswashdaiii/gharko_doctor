import 'package:gharko_doctor/app/constant/hive_table_constant.dart';
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

  //Authentication queries
    Future<void> register(UserHiveModel auth) async {
    var box = await Hive.openBox<UserHiveModel>(
      HiveTableConstant.userBox,
    );
    await box.put(auth.userId, auth);
  }

  // Future<void> deleteAuth(String id) async {
  //   var box = await Hive.openBox<UserHiveModel>(
  //     HiveTableConstant.userBox,
  //   );
  //   await box.delete(id);
  // }

  // Future<List<UserHiveModel>> getAllAuth() async {
  //   var box = await Hive.openBox<UserHiveModel>(
  //     HiveTableConstant.userBox,
  //   );
  //   return box.values.toList();
  // }

  // Login using username and password
  Future<UserHiveModel?> login(String username, String password) async {
  var box = await Hive.openBox<UserHiveModel>(
    HiveTableConstant.userBox,
  );

  try {
    var user = box.values.firstWhere(
      (element) => element.username == username && element.password == password,
    );
    return user;
  } catch (e) {
    return null;
  } finally {
    await box.close();
  }
}

}