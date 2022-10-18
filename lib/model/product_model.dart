import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? coverImage;
  @HiveField(2)
  final String? chooseCategory;
  @HiveField(3)
  final String? productDescription;
  @HiveField(4)
  final String? quantity;
  @HiveField(5)
  final List<String>? listOfImage;
  @HiveField(6)
  final String? price;
  @HiveField(7)
  final List<String>? availableColours;
  @HiveField(8)
  final bool? isApproved;
  @HiveField(9)
  final List<Map>? variation;
  @HiveField(10)
  final Map? variationMap;

  ProductModel(
      {this.availableColours,
      this.listOfImage,
      this.price,
      this.quantity,
      this.productDescription,
      this.title,
      this.coverImage,
      this.chooseCategory,
      this.isApproved,
      this.variation,
      this.variationMap});
}
