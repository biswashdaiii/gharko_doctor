import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;
  final String gender;
  final String dob;
  final String lastSeen;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.address,
    required this.gender,
    required this.dob,
    required this.lastSeen,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      lastSeen: json['lastSeen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'address': address,
      'gender': gender,
      'dob': dob,
      'lastSeen': lastSeen,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
      address: address,
      gender: gender,
      dob: dob,
      lastSeen: lastSeen,
    );
  }

  static UserProfileModel fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      avatarUrl: entity.avatarUrl,
      address: entity.address,
      gender: entity.gender,
      dob: entity.dob,
      lastSeen: entity.lastSeen,
    );
  }
}
