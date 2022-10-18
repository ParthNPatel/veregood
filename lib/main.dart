import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_demo/controller/add_variation_controller.dart';
import 'package:hive_demo/controller/edit_product_controller.dart';
import 'package:hive_demo/view/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'model/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  Hive.registerAdapter(ProductModelAdapter());

  await Hive.openBox<ProductModel>("products");

  runApp(MyApp());
}

// class RestartWidget extends StatefulWidget {
//   RestartWidget({required this.child});
//
//   final Widget child;
//
//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
//   }
//
//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }
//
// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VereGood',
          home: HomePage(),
        );
      },
    );
  }

  AddVariationController addVariationController =
      Get.put(AddVariationController());

  EditProductController editProductController =
      Get.put(EditProductController());
}
