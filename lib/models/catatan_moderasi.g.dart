// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catatan_moderasi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatatanModerasiAdapter extends TypeAdapter<CatatanModerasi> {
  @override
  final int typeId = 0;

  @override
  CatatanModerasi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatatanModerasi(
      judulBuku: fields[0] as String,
      namaPengulas: fields[1] as String,
      isiUlasan: fields[2] as String,
      statusTindakan: fields[3] as String,
      tanggal: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CatatanModerasi obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.judulBuku)
      ..writeByte(1)
      ..write(obj.namaPengulas)
      ..writeByte(2)
      ..write(obj.isiUlasan)
      ..writeByte(3)
      ..write(obj.statusTindakan)
      ..writeByte(4)
      ..write(obj.tanggal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatatanModerasiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
