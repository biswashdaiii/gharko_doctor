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
    Future<void> registerUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(
      HiveTableConstant.userBox,
    );
    await box.put(user.userId, user);
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
  Future<UserHiveModel?> loginUSer(String email, String password) async {
  var box = await Hive.openBox<UserHiveModel>(
    HiveTableConstant.userBox,
  );
   var user = box.values.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => throw Exception('Invalid username or password'),
    );
    box.close();
    return user;

}

}