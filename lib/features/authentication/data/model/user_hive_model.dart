
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
  final String fullName;

   @HiveField(2)
  final String  email;

   @HiveField(3)
  final String  password;
 
  UserHiveModel({
  String? userId,
  required this.fullName,
  required this.email,
  required this.password,
}) : userId = userId ?? Uuid().v4();



  //initial constructor
  const UserHiveModel.initial():
    userId='',
    fullName='',
    email='',
    password='';


//from entity
  factory UserHiveModel.fromEntity(UserEntity user){
    return UserHiveModel( 
      userId:user.userId,
      fullName:user.fullName,
      email:user.email,
      password:user.password);

  }

  //to entity
  UserEntity toEntity()=>UserEntity(
    userId:userId,
    fullName: fullName, 
    email: email,
    password: password);

  

  @override
  List<Object?> get props => [
    userId,
    fullName,
    email,
    password,
  ];
}