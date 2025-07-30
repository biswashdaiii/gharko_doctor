// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 2;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentModel(
      userId: fields[0] as String,
      docId: fields[1] as String,
      slotDate: fields[2] as String,
      slotTime: fields[3] as String,
      docData: (fields[4] as Map).cast<String, dynamic>(),
      userData: (fields[5] as Map).cast<String, dynamic>(),
      amount: fields[6] as double,
      date: fields[7] as DateTime,
      cancelled: fields[8] as bool,
      payment: fields[9] as double?,
      isCompleted: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.docId)
      ..writeByte(2)
      ..write(obj.slotDate)
      ..writeByte(3)
      ..write(obj.slotTime)
      ..writeByte(4)
      ..write(obj.docData)
      ..writeByte(5)
      ..write(obj.userData)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.cancelled)
      ..writeByte(9)
      ..write(obj.payment)
      ..writeByte(10)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
