import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';
import '../view/add_product_screen.dart';

class SelectOptionDialog extends StatefulWidget {
  const SelectOptionDialog({Key? key}) : super(key: key);

  @override
  State<SelectOptionDialog> createState() => _SelectOptionDialogState();
}

class _SelectOptionDialogState extends State<SelectOptionDialog> {
  List options = [
    'SIMPLE',
    'VARIATION',
    'AUCTION',
    'QUOTE',
  ];

  int optionSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextConst.selectOption,
                style: TextStyle(color: Colors.black, fontSize: 13.sp),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/images/close.svg',
                  height: 27.sp,
                  width: 27.sp,
                ),
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Column(
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    optionSelected = index;
                  });

                  Navigator.pop(context);

                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(
                          isVariationVisible: false,
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddProductScreen(isVariationVisible: true),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(
                          isVariationVisible: false,
                        ),
                      ),
                    );
                  } else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(
                          isVariationVisible: false,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  height: 32.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: optionSelected == index ? blueColor : greyColor2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      options[index],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
