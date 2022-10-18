import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_demo/controller/edit_product_controller.dart';
import 'package:hive_demo/view/add_product_screen.dart';
import 'package:hive_demo/view/edit_product_screen.dart';
import 'package:sizer/sizer.dart';
import '../constant/categories_data.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';

class SelectSubCategory extends StatefulWidget {
  final categoryIndex;
  final bool? isContainVariation;
  final bool? isAdded;

  const SelectSubCategory(
      {Key? key,
      required this.categoryIndex,
      this.isContainVariation = false,
      this.isAdded})
      : super(key: key);

  @override
  State<SelectSubCategory> createState() => _SelectSubCategoryState();
}

class _SelectSubCategoryState extends State<SelectSubCategory> {
  EditProductController editProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    log('${widget.categoryIndex}');
    return Scaffold(
      backgroundColor: greyColor3,
      body: SafeArea(
        child: Column(
          children: [
            appHeader(),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: Categories.categories[widget.categoryIndex]['sub_category']
                          .length ==
                      0
                  ? Center(
                      child: Text("Sub Category Not Found"),
                    )
                  : ListView.builder(
                      itemCount: Categories
                          .categories[widget.categoryIndex]['sub_category']
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        log('run  ${Categories.categories[widget.categoryIndex].runtimeType}');
                        return ListTile(
                          onTap: () {
                            if (widget.isAdded == true) {
                              editProductController.categoryName =
                                  Categories.categories[widget.categoryIndex]
                                      ['sub_category'][index]['name'];

                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => AddProductScreen(
                              //       isVariationVisible:
                              //           widget.isContainVariation!,
                              //       category: Categories
                              //               .categories[widget.categoryIndex]
                              //           ['sub_category'][index]['name'],
                              //     ),
                              //   ),
                              // );
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProductScreen(
                                    category: Categories
                                            .categories[widget.categoryIndex]
                                        ['sub_category'][index]['name'],
                                  ),
                                ),
                              );
                            }
                          },
                          title: Text(
                            Categories.categories[widget.categoryIndex]
                                ['sub_category'][index]['name'],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container appHeader() {
    return Container(
      height: 65.sp,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/arrow_back.svg',
                      height: 27.sp,
                      width: 27.sp,
                    )),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  TextConst.chooseSubCategory,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 27.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
