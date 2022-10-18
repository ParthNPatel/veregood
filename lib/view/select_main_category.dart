import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_demo/view/select_sub_category.dart';
import 'package:sizer/sizer.dart';
import '../constant/categories_data.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';

class SelectMainCategory extends StatefulWidget {
  final bool? isContainVariation;
  final bool? isAdded;

  const SelectMainCategory(
      {Key? key, this.isContainVariation = false, this.isAdded})
      : super(key: key);

  @override
  State<SelectMainCategory> createState() => _SelectMainCategoryState();
}

class _SelectMainCategoryState extends State<SelectMainCategory> {
  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: Categories.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectSubCategory(
                              isAdded: widget.isAdded,
                              categoryIndex: index,
                              isContainVariation: widget.isContainVariation),
                        ),
                      );
                    },
                    title: Text(
                      Categories.categories[index]['name'],
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
                  TextConst.chooseMainCategory,
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
