// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_name_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNameModelAdapter extends TypeAdapter<UserNameModel> {
  @override
  final int typeId = 2;

  @override
  UserNameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNameModel(
      user: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserNameModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
