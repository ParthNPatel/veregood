import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/view/product_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Box<ProductModel>? _productBox;

  List<String> titles = [
    'Product',
    'Orders',
    'Payments',
    'KYC',
  ];

  List<String> images = [
    'assets/images/product.svg',
    'assets/images/orders.svg',
    'assets/images/payments.svg',
    'assets/images/kyc.svg',
  ];

  // Future _openBox() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   _productBox = await Hive.openBox<ProductModel>('products');
  //   return;
  // }
  //
  // @override
  // void initState() {
  //   Hive.registerAdapter(ProductModelAdapter());
  //   _openBox();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60.sp,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: Row(
          children: [
            SizedBox(
              width: 4.w,
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/images/profile.svg',
                height: 30.sp,
                width: 30.sp,
              ),
            ),
          ],
        ),
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 50.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            childAspectRatio: 2.sp / 2.6.sp,
          ),
          itemBuilder: (context, index) => Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(),
                        ));
                  }
                },
                child: Container(
                  height: 120.sp,
                  width: 120.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      images[index],
                      height: index == 2 || index == 3 ? 60.sp : 70.sp,
                      width: index == 2 || index == 3 ? 60.sp : 70.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                titles[index],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
