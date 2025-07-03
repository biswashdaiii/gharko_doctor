import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;

    @JsonKey(name: 'name') 
  final String fullName;
  
  final String email;
  final String password;
 

  const UserApiModel({
    this.userId,
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

//to entity
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      password: password,
    );
  }
  // from entity
  factory UserApiModel.fromEntity(UserEntity entity) {
    final user=UserApiModel(email: entity.email, fullName: entity.fullName, password: entity.password); 
    return user;
     

  }
  

  
  @override
  // TODO: implement props
  List<Object?> get props => [  
    userId,
    fullName,
    email,
    password,
  ];
}