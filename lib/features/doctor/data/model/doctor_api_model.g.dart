// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorApiModel _$DoctorApiModelFromJson(Map<String, dynamic> json) =>
    DoctorApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      speciality: json['speciality'] as String,
      degree: json['degree'] as String,
      experience: json['experience'] as String,
      available: json['available'] as bool? ?? false,
      fee: (json['fee'] as num).toInt(),
      about: json['about'] as String,
      date: json['date'] as String,
      address:
          AddressApiModel.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorApiModelToJson(DoctorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'speciality': instance.speciality,
      'degree': instance.degree,
      'experience': instance.experience,
      'available': instance.available,
      'fee': instance.fee,
      'about': instance.about,
      'date': instance.date,
      'address': instance.address,
    };

AddressApiModel _$AddressApiModelFromJson(Map<String, dynamic> json) =>
    AddressApiModel(
      line1: json['line1'] as String,
    );

Map<String, dynamic> _$AddressApiModelToJson(AddressApiModel instance) =>
    <String, dynamic>{
      'line1': instance.line1,
    };
