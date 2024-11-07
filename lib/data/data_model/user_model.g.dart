// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      displayName: fields[0] as String?,
      email: fields[1] as String?,
      emailVerified: fields[2] as bool?,
      isAnonymous: fields[3] as bool?,
      phoneNumber: fields[4] as String?,
      photoURL: fields[5] as String?,
      refreshToken: fields[6] as String?,
      tenantId: fields[7] as String?,
      uid: fields[8] as String?,
      companyType: fields[9] as String?,
      companyDocumentId: fields[10] as String?,
      companyName: fields[11] as String?,
      userType: fields[12] as String?,
      name: fields[13] as String?,
      address: fields[14] as String?,
      phoneNumbers: (fields[15] as List?)?.cast<dynamic>(),
      description: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.emailVerified)
      ..writeByte(3)
      ..write(obj.isAnonymous)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.photoURL)
      ..writeByte(6)
      ..write(obj.refreshToken)
      ..writeByte(7)
      ..write(obj.tenantId)
      ..writeByte(8)
      ..write(obj.uid)
      ..writeByte(9)
      ..write(obj.companyType)
      ..writeByte(10)
      ..write(obj.companyDocumentId)
      ..writeByte(11)
      ..write(obj.companyName)
      ..writeByte(12)
      ..write(obj.userType)
      ..writeByte(13)
      ..write(obj.name)
      ..writeByte(14)
      ..write(obj.address)
      ..writeByte(15)
      ..write(obj.phoneNumbers)
      ..writeByte(16)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
