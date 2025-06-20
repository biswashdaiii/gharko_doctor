
import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/app/constant/hive_table_constant.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';


part 'user_hive_model.g.dart';
@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{

   @HiveField(0)
  final String ?userId;
  
   @HiveField(1)
  final String phone;

   @HiveField(2)
  final String  username;

   @HiveField(3)
  final String  password;
 
  UserHiveModel({
  String? userId,
  required this.phone,
  required this.username,
  required this.password,
}) : userId = userId ?? Uuid().v4();



  //initial constructor
  const UserHiveModel.initial():
    userId='',
    phone='',
    username='',
    password='';


//from entity
  factory UserHiveModel.fromEntity(UserEntity user){
    return UserHiveModel( 
      userId:user.userId,
      phone:user.phone,
      username:user.phone,
      password:user.password);

  }

  //to entity
  UserEntity toEntity()=>UserEntity(
    userId:userId,
    phone: phone, 
    username: username,
     password: password);

  

  @override
  List<Object?> get props => [
    userId,
    phone,
    username,
    password,
  ];
}