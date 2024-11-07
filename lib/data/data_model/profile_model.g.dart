// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 1;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      documentId: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      emailAddress: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      address: fields[5] as String?,
      gender: fields[6] as String?,
      DOB: fields[8] as String?,
      bloodGroup: fields[9] as String?,
      nationality: fields[10] as String?,
      religion: fields[11] as String?,
      age: fields[12] as String?,
      designation: fields[13] as String?,
      lastModified: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.documentId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.emailAddress)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.lastModified)
      ..writeByte(8)
      ..write(obj.DOB)
      ..writeByte(9)
      ..write(obj.bloodGroup)
      ..writeByte(10)
      ..write(obj.nationality)
      ..writeByte(11)
      ..write(obj.religion)
      ..writeByte(12)
      ..write(obj.age)
      ..writeByte(13)
      ..write(obj.designation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
