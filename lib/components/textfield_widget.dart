import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constant/color_const.dart';

class TextFieldWidget extends StatelessWidget {
  final hintText;
  final keyBoardType;
  final maxLenght;
  final TextEditingController controller;
  final inpuFormator;

  const TextFieldWidget(
      {required this.hintText,
      this.keyBoardType,
      this.maxLenght,
      required this.controller,
      this.inpuFormator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.sp,
      child: TextFormField(
        inputFormatters: inpuFormator,
        maxLength: maxLenght,
        controller: controller,
        keyboardType: keyBoardType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: const TextStyle(color: greyColor2),
            border: InputBorder.none),
      ),
    );
  }
}

// TextFormField(
// decoration: InputDecoration(
// filled: true,
// fillColor: Colors.white,
// hintText: TextConst.title1,
// hintStyle: const TextStyle(color: greyColor2),
// border: InputBorder.none),
// ),
