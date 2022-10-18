import 'package:get/get.dart';

class AddVariationController extends GetxController {
  // dynamic mm={
  //   "mm":{
  //     "m":"k",
  //   }
  // }
  List<Map<String, dynamic>> _addVariation = [];

  List<Map<String, dynamic>> get addVariation => _addVariation;

  set addVariation(List<Map<String, dynamic>> value) {
    _addVariation = value;
    update();
  }

  List<String> _listOfVariation = [];

  List<String> get listOfVariation => _listOfVariation;

  set listOfVariation(List<String> value) {
    _listOfVariation = value;
    update();
  }

  List<List<String>> _listOfShowVariation = [];

  List<List<String>> get listOfShowVariation => _listOfShowVariation;

  set listOfShowVariation(List<List<String>> value) {
    _listOfShowVariation = value;
    update();
  }
}
