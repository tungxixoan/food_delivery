// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_bopy.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print("Height : "+MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20, top: 0, right: Dimensions.width20, bottom: 0 ),
              // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                padding: EdgeInsets.only(left: 0, top: Dimensions.height10, right: 0, bottom:  Dimensions.height10 ),
                // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: 'Bangladesh', color: AppColors.mainColor,),
                        Row(
                          children: [
                            SmallText(text: 'Narshingdi', color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_rounded,)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.search, color: Colors.white, size: Dimensions.icon24,),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: FoodPageBody(),))
          ],
        )
      ),
    );
  }
}
/// 39 phuts