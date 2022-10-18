// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      availableColours: (fields[7] as List?)?.cast<String>(),
      listOfImage: (fields[5] as List?)?.cast<String>(),
      price: fields[6] as String?,
      quantity: fields[4] as String?,
      productDescription: fields[3] as String?,
      title: fields[0] as String?,
      coverImage: fields[1] as String?,
      chooseCategory: fields[2] as String?,
      isApproved: fields[8] as bool?,
      variation: (fields[9] as List?)?.cast<Map>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.coverImage)
      ..writeByte(2)
      ..write(obj.chooseCategory)
      ..writeByte(3)
      ..write(obj.productDescription)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.listOfImage)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.availableColours)
      ..writeByte(8)
      ..write(obj.isApproved)
      ..writeByte(9)
      ..write(obj.variation)
      ..writeByte(10)
      ..write(obj.variationMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
