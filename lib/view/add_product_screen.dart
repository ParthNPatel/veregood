import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/controller/edit_product_controller.dart';
import 'package:hive_demo/view/home_page.dart';
import 'package:hive_demo/view/product_screen.dart';
import 'package:hive_demo/view/select_main_category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';
import '../components/snack_bar_widget.dart';
import '../components/textfield_widget.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';
import '../controller/add_variation_controller.dart';
import '../main.dart';
import '../model/product_model.dart';
import 'package:hive/hive.dart';

class AddProductScreen extends StatefulWidget {
  final bool isVariationVisible;
  String? category;

  AddProductScreen({this.isVariationVisible = false, this.category});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  EditProductController editProductController = Get.find();

  Box<ProductModel>? productBox;

  final title = TextEditingController();
  final productDescription = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();
  final variationGroupName = TextEditingController();
  final titleDialog = TextEditingController();
  final uom = TextEditingController();
  final priceDialog = TextEditingController();
  final text1 = TextEditingController();
  final text2 = TextEditingController();
  final text3 = TextEditingController();
  final text4 = ImagePicker();

  bool isAdded = false;
  List<String> imageOfVarition = [];
  // List<XFile> variationCoverImage = [];

  List<String> selectedImages = [];
  AddVariationController _addVariationController = Get.find();

  File? coverImage;

  final picker = ImagePicker();

  void selectCoverImage() async {
    final obtainedFile = await picker.pickImage(source: ImageSource.gallery);

    if (obtainedFile != null) {
      setState(() {
        coverImage = File(obtainedFile.path);
      });
    } else {
      log('canceled');
    }
  }

  List<XFile> additionalPhoto = [];

  List<String> images = [];

  void selectAdditionalPhotos() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      additionalPhoto.addAll(selectedImages);

      selectedImages.forEach((element) {
        images.add(element.path);
      });
    }
    print("Image List Length:${additionalPhoto.length}");
    setState(() {});
  }

  @override
  void initState() {
    productBox = Hive.box<ProductModel>("products");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _addVariationController.addVariation.clear();
        widget.category = "";
        Get.off(() => ProductScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: greyColor3,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appHeader(),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectCoverImage();
                            },
                            child: Container(
                                height: 105.sp,
                                width: 90.sp,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: coverImage == null
                                      ? Center(
                                          child: Text(
                                            TextConst.coverImage,
                                            style: TextStyle(
                                                color: greyColor2,
                                                fontSize: 13.sp),
                                          ),
                                        )
                                      : Image.file(
                                          coverImage!,
                                          fit: BoxFit.cover,
                                        ),
                                )),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 52.w,
                            child: Column(
                              children: [
                                TextFieldWidget(
                                    hintText: TextConst.title1,
                                    controller: title),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SelectMainCategory(
                                                  isAdded: true,
                                                  isContainVariation: widget
                                                      .isVariationVisible),
                                        ),
                                      );
                                    },
                                    child: GetBuilder<EditProductController>(
                                      builder: (controller) => Container(
                                        height: 40.sp,
                                        width: double.infinity,
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 11.sp,
                                            ),
                                            controller.categoryName == ""
                                                ? Text(
                                                    TextConst.chooseCategory,
                                                    style: const TextStyle(
                                                        color: greyColor2),
                                                  )
                                                : Text(
                                                    controller.categoryName,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 130.sp,
                        child: TextFormField(
                          maxLines: 15,
                          controller: productDescription,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: TextConst.description,
                              hintStyle: const TextStyle(color: greyColor2),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFieldWidget(
                        inpuFormator: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        hintText: TextConst.quantity,
                        controller: quantity,
                        keyBoardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFieldWidget(
                        hintText: TextConst.price,
                        controller: price,
                        keyBoardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(
                                additionalPhoto.length,
                                (index) => Container(
                                  margin: EdgeInsets.only(right: 3.w),
                                  height: 51.sp,
                                  width: 51.sp,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: additionalPhoto[index]
                                          .path
                                          .toString()
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            TextConst.image,
                                            style: TextStyle(
                                                color: greyColor2,
                                                fontSize: 11.sp),
                                          ),
                                        )
                                      : Stack(
                                          children: [
                                            Image.file(
                                              File(additionalPhoto[index].path),
                                              height: 51.sp,
                                              width: 51.sp,
                                              fit: BoxFit.cover,
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 3.sp, top: 3.sp),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      additionalPhoto
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/close.svg",
                                                    height: 15.sp,
                                                    width: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectAdditionalPhotos();
                              },
                              child: Container(
                                height: 51.sp,
                                width: 68.sp,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: RDottedLineBorder.all(
                                      width: 1, color: Colors.grey),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/upload_image.png',
                                        height: 15.sp,
                                        width: 15.sp,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Center(
                                        child: Text(
                                          TextConst.uploadImage,
                                          style: TextStyle(
                                              color: greyColor2,
                                              fontSize: 8.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.isVariationVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              TextConst.variation,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            GetBuilder<AddVariationController>(
                              builder: (controller) {
                                return Column(
                                  children: List.generate(
                                      controller.addVariation.length,
                                      (indexSecond) {
                                    return controller.addVariation.length == 0
                                        ? SizedBox()
                                        : controller.addVariation[indexSecond][
                                                        'variation_group_name'] !=
                                                    null &&
                                                controller
                                                        .addVariation[
                                                            indexSecond]
                                                            ['image']
                                                        .length ==
                                                    0
                                            ? staticVariation(
                                                context,
                                                controller,
                                                indexSecond,
                                                controller.addVariation[
                                                        indexSecond]
                                                    ['variation_group_name'])
                                            : Stack(
                                                children: [
                                                  Container(
                                                    height: 95.sp,
                                                    margin: EdgeInsets.only(
                                                        bottom: 2.h),
                                                    width: double.infinity,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4.w,
                                                          right: 4.w,
                                                          top: 3.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .addVariation[
                                                                        indexSecond]
                                                                        [
                                                                        'variation_group_name']
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      greyColor3,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 4.w,
                                                              ),
                                                              InkResponse(
                                                                onTap: () {
                                                                  updateVariationGroupName(
                                                                      indexSecond:
                                                                          indexSecond);
                                                                },
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              children: [
                                                                Row(
                                                                  children: List
                                                                      .generate(
                                                                    controller
                                                                        .addVariation[
                                                                            indexSecond]
                                                                            [
                                                                            'image']
                                                                        .length,
                                                                    (indexOf) => showVariationWidget(
                                                                        context,
                                                                        indexSecond,
                                                                        controller,
                                                                        indexOf),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      isAdded =
                                                                          true;
                                                                    });
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            StatefulBuilder(
                                                                              builder: (context, setState) {
                                                                                return GetBuilder<AddVariationController>(
                                                                                  builder: (controller) {
                                                                                    return Dialog(
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                        ),
                                                                                        backgroundColor: blueColor1,
                                                                                        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.symmetric(
                                                                                            horizontal: 8.w,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                height: 3.h,
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    TextConst.createNewVariation,
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
                                                                                              GestureDetector(
                                                                                                onTap: () async {
                                                                                                  imageOfVarition.clear();
                                                                                                  final List<XFile>? obtainedFile = await picker.pickMultiImage();

                                                                                                  if (obtainedFile != null) {
                                                                                                    obtainedFile.forEach((element) {
                                                                                                      imageOfVarition.add(element.path);
                                                                                                    });

                                                                                                    setState(() {});
                                                                                                  } else {
                                                                                                    log('canceled');
                                                                                                  }

                                                                                                  ///
                                                                                                  Map<String, String> data = {};
                                                                                                  for (int i = 0; i < controller.addVariation[indexSecond]['image'].length; i++) {
                                                                                                    try {
                                                                                                      data.addAll({
                                                                                                        'image$i': controller.addVariation[indexSecond]['image']['image$i']
                                                                                                      });
                                                                                                    } catch (e) {}
                                                                                                  }
                                                                                                  for (int i = 0; i < imageOfVarition.length; i++) {
                                                                                                    data.addAll({
                                                                                                      'image${i + controller.addVariation[indexSecond]['image'].length}': imageOfVarition[i]
                                                                                                    });
                                                                                                  }
                                                                                                  print('data kn   ${data}');
                                                                                                  _addVariationController.addVariation[indexSecond] = {
                                                                                                    'variation_group_name': _addVariationController.addVariation[indexSecond]['variation_group_name'],
                                                                                                    'image': data,
                                                                                                    'title': _addVariationController.addVariation[indexSecond]['title'],
                                                                                                    'uom': _addVariationController.addVariation[indexSecond]['uom'],
                                                                                                    'price': _addVariationController.addVariation[indexSecond]['price']
                                                                                                  };
                                                                                                  setState(() {});
                                                                                                },
                                                                                                child: Container(
                                                                                                  height: 51.sp,
                                                                                                  width: 75.sp,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                    border: RDottedLineBorder.all(width: 1, color: Colors.grey),
                                                                                                  ),
                                                                                                  child: Center(
                                                                                                    child: imageOfVarition.length == 0
                                                                                                        ? Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Image.asset(
                                                                                                                'assets/images/upload_image.png',
                                                                                                                height: 15.sp,
                                                                                                                width: 15.sp,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                height: 1.h,
                                                                                                              ),
                                                                                                              Center(
                                                                                                                child: Text(
                                                                                                                  TextConst.uploadImage,
                                                                                                                  style: TextStyle(color: greyColor2, fontSize: 8.sp),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          )
                                                                                                        : Align(
                                                                                                            alignment: Alignment.center,
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsets.only(left: 5.w),
                                                                                                              child: Text(
                                                                                                                TextConst.imageUploaded,
                                                                                                                style: TextStyle(color: greenColor, fontSize: 11.sp),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3.h,
                                                                                              ),
                                                                                              TextFieldWidget(hintText: TextConst.title1, controller: text1),
                                                                                              SizedBox(
                                                                                                height: 3.h,
                                                                                              ),
                                                                                              TextFieldWidget(hintText: TextConst.uom, controller: text2),
                                                                                              SizedBox(
                                                                                                height: 3.h,
                                                                                              ),
                                                                                              TextFieldWidget(
                                                                                                hintText: TextConst.price,
                                                                                                controller: text3,
                                                                                                keyBoardType: TextInputType.number,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 3.h,
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  setState(
                                                                                                    () {},
                                                                                                  );
                                                                                                  imageOfVarition.clear();
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Container(
                                                                                                  height: 40.sp,
                                                                                                  width: 80.sp,
                                                                                                  decoration: const BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      TextConst.add,
                                                                                                      style: const TextStyle(color: blueColor, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 4.h,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ));
                                                                                  },
                                                                                );
                                                                              },
                                                                            )).then(
                                                                        (value) {
                                                                      text1
                                                                          .clear();
                                                                      text2
                                                                          .clear();
                                                                      text3
                                                                          .clear();

                                                                      imageOfVarition
                                                                          .clear();

                                                                      setState(
                                                                          () {});
                                                                    });
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        18.sp,
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    backgroundColor:
                                                                        greyColor3,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 7.sp,
                                                          top: 7.sp),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _addVariationController
                                                                .addVariation
                                                                .removeAt(
                                                                    indexSecond);
                                                          });
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/images/close.svg",
                                                          height: 17.sp,
                                                          width: 17.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                  }),
                                );
                              },
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            firstDialog(context),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {
                            if (coverImage != null &&
                                title.text.isNotEmpty &&
                                editProductController.categoryName != "" &&
                                productDescription.text.isNotEmpty &&
                                quantity.text.isNotEmpty &&
                                price.text.isNotEmpty &&
                                additionalPhoto.length.toString().isNotEmpty) {
                              if (double.tryParse(price.text) != null) {
                                log('Variation------${_addVariationController.addVariation}');
                                Map finalData = {};
                                for (int i = 0;
                                    i <
                                        _addVariationController
                                            .addVariation.length;
                                    i++) {
                                  // List imagePass = [];
                                  // _addVariationController.addVariation[i]
                                  //         ['image']
                                  //     .forEach((key, value) {
                                  //   imagePass.add(value);
                                  // });
                                  // print('image of lis image $imagePass');
                                  finalData.addAll({
                                    '$i': {
                                      "variation_group_name":
                                          _addVariationController
                                                  .addVariation[i]
                                              ['variation_group_name'],
                                      'image': _addVariationController
                                          .addVariation[i]['image'],
                                      'title': _addVariationController
                                          .addVariation[i]['title'],
                                      'uom': _addVariationController
                                          .addVariation[i]['uom'],
                                      'price': _addVariationController
                                          .addVariation[i]['price']
                                    }
                                  });
                                }
                                print('final tuch og ${finalData}');
                                ProductModel model = ProductModel(
                                    variation:
                                        _addVariationController.addVariation,
                                    coverImage: coverImage!.path,
                                    title: title.text,
                                    chooseCategory:
                                        editProductController.categoryName,
                                    productDescription: productDescription.text,
                                    quantity: quantity.text,
                                    price: price.text,
                                    availableColours: ['0xffffff'],
                                    listOfImage: images,
                                    variationMap: finalData,
                                    isApproved: false);

                                await productBox!.add(model);
                                editProductController.categoryName = "";
                                _addVariationController.addVariation.clear();
                                //Get.back();

                                print("Hiii");
                                //Hive.resetAdapters();
                                //Hive.registerAdapter(ProductModelAdapter());
                                //RestartWidget.restartApp(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(),
                                    ));
                              } else {
                                CommonSnackBar.getSnackBar(
                                    context: context,
                                    message: "Please enter valid price");
                              }
                            } else {
                              CommonSnackBar.getSnackBar(
                                  context: context,
                                  message:
                                      "Please enter all the required fields");
                            }
                          },
                          child: Container(
                            height: 45.sp,
                            width: 100.sp,
                            color: greenColor,
                            child: Center(
                              child: Text(
                                TextConst.add,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showVariationWidget(BuildContext context, int indexSecond,
      AddVariationController controller, int indexOf) {
    try {
      return Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Text("Do you want to delete this image?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("NO"),
                      ),
                      TextButton(
                        onPressed: () {
                          try {
                            _addVariationController
                                .addVariation[indexSecond]['image'].keys
                                .forEach((key) {
                              print('llllll $key');
                              if (controller.addVariation[indexSecond]['image']
                                      ['image$indexOf'] ==
                                  controller.addVariation[indexSecond]['image']
                                      [key]) {
                                _addVariationController
                                    .addVariation[indexSecond]['image']
                                    .remove(key);
                              }
                            });

                            Navigator.pop(context);
                          } catch (e) {
                            List savedData = [];
                            controller.addVariation[indexSecond]['image']
                                .forEach((e, v) {
                              savedData.add(v);
                            });
                            Map<String, String> data = {};
                            for (int i = 0; i < savedData.length; i++) {
                              try {
                                data.addAll({'image$i': savedData[i]});
                              } catch (e) {}
                            }

                            print('data kn   ${data}');
                            setState(() {});
                            _addVariationController.addVariation[indexSecond] =
                                {
                              'variation_group_name': _addVariationController
                                      .addVariation[indexSecond]
                                  ['variation_group_name'],
                              'image': data,
                              'title': _addVariationController
                                  .addVariation[indexSecond]['title'],
                              'uom': _addVariationController
                                  .addVariation[indexSecond]['uom'],
                              'price': _addVariationController
                                  .addVariation[indexSecond]['price']
                            };
                            print(
                                'huyuiefuiewfu b${controller.addVariation[indexSecond]['image']}');
                            Navigator.pop(context);
                          }
                          // _addVariationController.addVariation[indexSecond]['image'].remove(controller.addVariation[indexSecond]['image'][indexOf].keys());
                          //log('list of data ${controller.addVariation[indexSecond]['image']}');
                        },
                        child: Text("YES"),
                      ),
                    ],
                  );
                },
              ),
            ).then((value) {
              setState(() {});
            });
          },
          child: CircleAvatar(
            radius: 18.sp,
            backgroundImage: FileImage(
              File(
                controller.addVariation[indexSecond]['image']['image$indexOf'],
              ),
            ),
            backgroundColor: greyColor3,
          ),
        ),
      );
    } catch (e) {
      return SizedBox();
    }
  }

  Stack staticVariation(BuildContext context, AddVariationController controller,
      int variationIndex, String categoryName) {
    return Stack(
      children: [
        Container(
          height: 95.sp,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 2.h),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                        color: greyColor3,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // SizedBox(
                    //   width: 4.w,
                    // ),
                    // InkResponse(
                    //   onTap: () {
                    //     updateVariationGroupName(indexSecond: variationIndex);
                    //   },
                    //   child: Icon(
                    //     Icons.edit,
                    //     size: 20,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: CircleAvatar(
                            radius: 16.sp,
                            backgroundColor: greyColor3,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        imageOfVarition.clear();
                        secondDialog(
                            context: context,
                            addVariationIndex: variationIndex);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        radius: 16.sp,
                        backgroundColor: greyColor3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: 7.sp, top: 7.sp),
            child: InkWell(
              onTap: () {
                setState(() {
                  _addVariationController.addVariation.removeAt(variationIndex);
                });
              },
              child: SvgPicture.asset(
                "assets/images/close.svg",
                height: 17.sp,
                width: 17.sp,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  GestureDetector firstDialog(BuildContext context) {
    return GestureDetector(
      onTap: () {
        variationGroupName.clear();
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: blueColor1,
                  insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              TextConst.createNewVariation,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.sp),
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
                        TextFieldWidget(
                            hintText: TextConst.variationGroupName,
                            controller: variationGroupName),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/images/check-square.svg',
                              height: 27.sp,
                              width: 27.sp,
                            ),
                            Text(
                              TextConst.variationGroupName,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            imageOfVarition.clear();

                            if (variationGroupName.text.isNotEmpty) {
                              _addVariationController.addVariation.add({
                                'variation_group_name': variationGroupName.text,
                                'image': [],
                              });
                              log('list of pre ${_addVariationController.addVariation[0]['image'].length}');
                              Navigator.pop(context);
                            } else {
                              CommonSnackBar.getSnackBar(
                                  context: context,
                                  message: 'Please enter variation group name');
                            }
                          },
                          child: Container(
                            height: 40.sp,
                            width: 80.sp,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                TextConst.submit,
                                style: const TextStyle(
                                    color: blueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ).then((value) {
          setState(() {});
        });
      },
      child: Container(
        height: 50.sp,
        width: double.infinity,
        color: blueColor,
        child: Center(
          child: Text(
            TextConst.addAnotherVariation,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> secondDialog(
      {required BuildContext context, required int addVariationIndex}) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return GetBuilder<AddVariationController>(
            builder: (controller) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: blueColor1,
                  insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              TextConst.createNewVariation,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.sp),
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
                        GestureDetector(
                          onTap: () async {
                            final List<XFile>? obtainedFile =
                                await picker.pickMultiImage();

                            if (obtainedFile != null) {
                              imageOfVarition.clear();
                              obtainedFile.forEach((element) {
                                imageOfVarition.add(element.path);
                              });
                              log('image for variation $imageOfVarition }');
                              setState(() {});
                            } else {
                              log('canceled');
                            }
                          },
                          child: Container(
                            height: 51.sp,
                            width: 75.sp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: RDottedLineBorder.all(
                                  width: 1, color: Colors.grey),
                            ),
                            child: Center(
                              child: imageOfVarition.length == 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/upload_image.png',
                                          height: 15.sp,
                                          width: 15.sp,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Center(
                                          child: Text(
                                            TextConst.uploadImage,
                                            style: TextStyle(
                                                color: greyColor2,
                                                fontSize: 8.sp),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Text(
                                          TextConst.imageUploaded,
                                          style: TextStyle(
                                              color: greenColor,
                                              fontSize: 11.sp),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFieldWidget(
                            hintText: TextConst.title1,
                            controller: titleDialog),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFieldWidget(
                            hintText: TextConst.uom, controller: uom),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextFieldWidget(
                          hintText: TextConst.price,
                          controller: priceDialog,
                          keyBoardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (imageOfVarition.length != 0 &&
                                titleDialog.text.isNotEmpty &&
                                uom.text.isNotEmpty &&
                                priceDialog.text.isNotEmpty) {
                              log('Images==imageOfVarition>$imageOfVarition');
                              Map<String, String> data = {};

                              for (int i = 0; i < imageOfVarition.length; i++) {
                                data.addAll({'image$i': imageOfVarition[i]});
                              }

                              print('data kn   $data');
                              _addVariationController
                                  .addVariation[addVariationIndex] = {
                                'variation_group_name': _addVariationController
                                        .addVariation[addVariationIndex]
                                    ['variation_group_name'],
                                'image': data,
                                'title': titleDialog.text,
                                'uom': uom.text,
                                'price': priceDialog.text
                              };

                              log('Images====---] ${_addVariationController.addVariation[0]['image']}');
                              imageOfVarition.clear();
                              Navigator.pop(context);
                            } else {
                              CommonSnackBar.getSnackBar(
                                  context: context,
                                  message:
                                      'Please enter all the required fields');
                            }
                          },
                          child: Container(
                            height: 40.sp,
                            width: 80.sp,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                TextConst.add,
                                style: const TextStyle(
                                    color: blueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    ).then((value) {
      if (titleDialog.text.isNotEmpty &&
          uom.text.isNotEmpty &&
          priceDialog.text.isNotEmpty) {
        titleDialog.clear();
        uom.clear();
        priceDialog.clear();
        variationGroupName.clear();
      } else {
        _addVariationController.addVariation[addVariationIndex]
            .remove(addVariationIndex);
      }
      setState(() {});
    });
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
                  TextConst.newProduct,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 30.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateVariationGroupName({required int indexSecond}) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: blueColor1,
            insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TextConst.updateVariationName,
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
                  TextFieldWidget(
                      hintText: TextConst.variationGroupName,
                      controller: variationGroupName),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/images/check-square.svg',
                        height: 27.sp,
                        width: 27.sp,
                      ),
                      Text(
                        TextConst.variationGroupName,
                        style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      imageOfVarition.clear();

                      if (variationGroupName.text.isNotEmpty) {
                        List savedData = [];
                        _addVariationController.addVariation[indexSecond]
                                ['image']
                            .forEach((e, v) {
                          savedData.add(v);
                        });
                        Map<String, String> data = {};
                        for (int i = 0; i < savedData.length; i++) {
                          try {
                            data.addAll({'image$i': savedData[i]});
                          } catch (e) {
                            data = {};
                          }
                        }

                        print('data kn   $data');
                        setState(() {});
                        _addVariationController.addVariation[indexSecond] = {
                          'variation_group_name': variationGroupName.text,
                          'image': data,
                          'title': _addVariationController
                              .addVariation[indexSecond]['title'],
                          'uom': _addVariationController
                              .addVariation[indexSecond]['uom'],
                          'price': _addVariationController
                              .addVariation[indexSecond]['price']
                        };
                        //log('list of pre ${_addVariationController.addVariation[0]['image'].length}');
                        Navigator.pop(context);
                      } else {
                        CommonSnackBar.getSnackBar(
                            context: context,
                            message: 'Please enter variation group name');
                      }
                    },
                    child: Container(
                      height: 40.sp,
                      width: 80.sp,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          TextConst.submit,
                          style: const TextStyle(
                              color: blueColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).then((value) {
      setState(() {});
    });
  }

  void selectVariationCoverImage() async {
    final List<XFile>? obtainedFile = await picker.pickMultiImage();

    if (obtainedFile != null) {
      obtainedFile.forEach((element) {
        imageOfVarition.add(element.path);
      });
      setState(() {});
    } else {
      log('canceled');
    }
  }
}
