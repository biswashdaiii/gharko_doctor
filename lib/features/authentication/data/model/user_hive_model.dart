
import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/app/constant/hive_table_constant.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:hive_flutter/adapters.dart';


part 'user_hive_model.g.dart';
@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{

   @HiveField(0)
  final String phone;

   @HiveField(1)
  final String  username;

   @HiveField(2)
  final String  password;
 
  UserHiveModel({
     required this.phone,
    required this.username,
    required this.password,
  }); 

  factory UserHiveModel.fromEntity(UserEntity user){
    return UserHiveModel(phone:user.phone,username:user.phone,password:user.password);

  }
  UserEntity toEntity()=>UserEntity(phone: phone, username: username, password: password);

  



  @override
  List<Object?> get props => [
    phone,
    username,
    password,
  ];
}