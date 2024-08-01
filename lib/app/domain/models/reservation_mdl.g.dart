// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_mdl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReservationAdapter extends TypeAdapter<Reservation> {
  @override
  final int typeId = 1;

  @override
  Reservation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reservation(
      id: fields[1] as int,
      userId: fields[2] as int,
      date: fields[3] as String,
      timeInit: fields[4] as String,
      timeFinal: fields[5] as String,
      duration: fields[6] as int,
      instructor: fields[7] as dynamic,
      courtId: fields[8] as int,
      courtType: fields[9] as String,
      chanceOfRain: fields[10] as dynamic,
      comment: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Reservation obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.timeInit)
      ..writeByte(5)
      ..write(obj.timeFinal)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.instructor)
      ..writeByte(8)
      ..write(obj.courtId)
      ..writeByte(9)
      ..write(obj.courtType)
      ..writeByte(10)
      ..write(obj.chanceOfRain)
      ..writeByte(11)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
