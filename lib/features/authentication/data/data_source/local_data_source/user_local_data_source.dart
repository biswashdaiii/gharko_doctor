import 'package:gharko_doctor/core/network/hive_services.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/user-data_source.dart';
import 'package:gharko_doctor/features/authentication/data/model/user_hive_model.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';

class UserLocalDataSource implements IUserDataSource{
  final HiveServices _hiveServices;

  UserLocalDataSource({
    required HiveServices hiveServices,
  }) : _hiveServices = hiveServices;


  @override
  Future<String> loginUser(String email, String password) async{
    try {
      final user = await _hiveServices.login(email, password);
      if (user == null) {
        throw Exception('Invalid username or password');
      }
      return user.userId ?? '';
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  
  }

  @override
  Future<void> registerUser(UserEntity user)async {
    try {
      //to model
      final userModel = UserHiveModel.fromEntity(user);
      await _hiveServices.register(userModel);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}