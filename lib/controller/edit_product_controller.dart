import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class EditProductController extends GetxController {
  String? coverImage;
  String? title;
  String? category;
  String? description;
  String? quantity;
  String? price;
  List<String>? images;
  int? index;
  bool? isVariationVisible;
  String _categoryName = '';
  List<Map<dynamic, dynamic>>? variation;

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
    update();
  }

  void addProductDetail({
    List<Map<dynamic, dynamic>>? variation,
    String? coverImage,
    String? title,
    String? category,
    String? description,
    String? quantity,
    String? price,
    List<String>? images,
    int? index,
    bool? isVariationVisible,
  }) {
    this.variation = variation;
    this.coverImage = coverImage;
    this.title = title;
    this.category = category;
    this.description = description;
    this.quantity = quantity;
    this.price = price;
    this.images = images;
    this.index = index;
    this.isVariationVisible = isVariationVisible;
    update();
  }

  Future<void> init(Function onDoneInitializing) async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    onDoneInitializing();
  }
}
