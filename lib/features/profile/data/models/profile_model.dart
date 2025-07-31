import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatarUrl: json['avatarUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
      };

  UserProfileEntity toEntity() => UserProfileEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
      );

  static UserProfileModel fromEntity(UserProfileEntity entity) => UserProfileModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        avatarUrl: entity.avatarUrl,
      );
}
