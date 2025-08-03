import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'doctor_api_model.g.dart';

@JsonSerializable()
class DoctorApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String image;
  final String speciality;
  final String degree;
  final String experience;
  @JsonKey(name: 'avaiable')
  final bool available;
  final int fee;
  final String about;
  final String date;
  final AddressApiModel address;

  const DoctorApiModel({
    this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.speciality,
    required this.degree,
    required this.experience,
    required this.available,
    required this.fee,
    required this.about,
    required this.date,
    required this.address,
  });

  factory DoctorApiModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorApiModelToJson(this);

  // to domain entity
  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id ?? '',
      name: name,
      email: email,
      imageUrl: image,
      speciality: speciality,
      degree: degree,
      experience: experience,
      available: available,
      fee: fee,
      about: about,
      date: date,
      address: address.line1,
    );
  }

  // from domain entity
  factory DoctorApiModel.fromEntity(DoctorEntity entity) {
    return DoctorApiModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      image: entity.imageUrl,
      speciality: entity.speciality,
      degree: entity.degree,
      experience: entity.experience,
      available: entity.available,
      fee: entity.fee,
      about: entity.about,
      date: entity.date,
      address: AddressApiModel(line1: entity.address),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        image,
        speciality,
        degree,
        experience,
        available,
        fee,
        about,
        date,
        address,
      ];
}

@JsonSerializable()
class AddressApiModel extends Equatable {
  final String line1;

  const AddressApiModel({required this.line1});

  factory AddressApiModel.fromJson(Map<String, dynamic> json) =>
      _$AddressApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressApiModelToJson(this);

  @override
  List<Object?> get props => [line1];
}
