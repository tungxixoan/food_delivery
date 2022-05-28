// import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_small_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction: 0.85); // Để hiện thị một kích thước nhỏ các page
  var _currPageValue = 0.0; //PageValue là giá trị vị trí của page,
  // Giá trị ban đầu là 0.0 khi a lướt sang page tiếp theo sẽ tăng lên 1.0
  double _scaleFactor = 0.8;
  double _height = Dimensions.height220;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController
            .page!; // _currPageValue sẽ gì giá trị vị trí page trong quá trình ta lướt sang pahe khác
        // print(_currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slide section
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoaded?Container(
            height: Dimensions.height320,
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProduct.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(
                    position, popularProduct.popularProductList[position]);
              }),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),

        // dots
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius5)),
            ),
          );
        }),
        // GetBuilder<PopularProductController>(builder: (pupolarProduct){

        // }),
        //2h40'
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width30, bottom: Dimensions.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: ".",
                    color: Colors.black26,
                  )),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(
                    text: "Food pairing",
                  ))
            ],
          ),
        ),
        
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
            shrinkWrap: true,
            physics:
                NeverScrollableScrollPhysics(), // shrinkWrap & physics dùng để  fix lỗi overflowed, fix lỗi thanh cuộn
            // nhưng trong trường hợp này nếu ko có SingleScrollView thì ko fix đucợ
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //Image section
                      Container(
                        width: Dimensions.width120,
                        height: Dimensions.width120,
                        decoration: BoxDecoration(
                          borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              AppConstants.BASE_URL+AppConstants.UPLOADS_URL+recommendedProduct.recommendedProductList[index].img!
                              )
                            )
                            ),
                      ),
                      //Text section
                      Expanded(
                          child: Container(
                        height: Dimensions.width100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              left: Dimensions.height10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                ExpandableSmallText(text: recommendedProduct.recommendedProductList[index].description!),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.7km",
                                      iconColor: AppColors.mainColor,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32min",
                                      iconColor: AppColors.iconColor2,
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })// Danh sách món ăn & image Popular
        
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity(); // 1h30'
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
           GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getPopularFood(index, "home"));
              },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                top: 0,
                right: Dimensions.width10,
                bottom: 0
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +AppConstants.UPLOADS_URL +popularProduct.img!
                  )
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(
                  left: Dimensions.width25,
                  top: 0,
                  right: Dimensions.width25,
                  bottom: Dimensions.height30),
              // margin: EdgeInsets.fromLTRB(25, 0, 25 , 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: Dimensions.radius5,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width10,
                    top: Dimensions.height10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
