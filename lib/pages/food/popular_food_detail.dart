import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final String page;
  final int pageId;
  const PopularFoodDetail({ Key? key, required this.pageId,required this.page }) : super(key: key);
// 3h18'
  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    //print("page is id "+pageId.toString());
    //print("page is name "+product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOADS_URL+product.img!
                  )
                )
              ),
            )
          ),
          Positioned(
            top: Dimensions.height40,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               GestureDetector(
                 onTap: () {
                   if (page=="cartpage") {
                     Get.toNamed(RouteHelper.getCartPage());
                   } else {
                     Get.toNamed(RouteHelper.getInitial());
                   }
                 },
                 child: AppIcon(icon: Icons.arrow_back_ios,)),
               GetBuilder<PopularProductController>(builder: (controller){
                 return GestureDetector(
                   onTap: () {
                     if (controller.totalItems>=1) {
                       Get.toNamed(RouteHelper.getCartPage());
                     }
                   },
                   child: Stack(
                     children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,),
                       controller.totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(icon: Icons.circle,
                           size: Dimensions.height20, 
                           iconColor: Colors.transparent,
                           backgroundColor: AppColors.mainColor,)):
                          Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 4,
                          top: 3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: Dimensions.height15, color: Colors.white,
                          )
                        ):
                        Container()
                     ],
                   ),
                 );
               })
              ],
            )
          ),
          Positioned(
            top: Dimensions.height350-20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20, right: Dimensions.width20, bottom: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20,),
                  topRight: Radius.circular(Dimensions.radius20,),

                ),
                color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,),
                    SizedBox(height: Dimensions.height15,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height15,),
                    // ExpandableTextWidget(text: "just the thought of having a complete course of about 27 hours for free shows your zeal to help as many people as possible to learn flutter. thanks for your time, effort and contribution to helping people become better versions of their self. hoping for the part 2 soon")
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(
                      text: product.description!)))
                    
                    //4h20
                  ]
                ),
            )
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
        height: Dimensions.height120,
        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width15, right: Dimensions.width15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            
            topLeft: Radius.circular(Dimensions.radius20*2), 
            topRight: Radius.circular(Dimensions.radius20*2)
           ),
           color: AppColors.buttonBackgroundColor,
          //  color: Colors.redAccent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(false);
                    },
                    child: Icon(Icons.remove, color: AppColors.signColor,)),
                  SizedBox(width: Dimensions.width15/2,),
                  BigText(text: popularProduct.inCartItem.toString()),
                  SizedBox(width: Dimensions.width15/2,),
                  GestureDetector(
                    onTap: () {
                      popularProduct.setQuantity(true);
                    },
                    child: Icon(Icons.add, color: AppColors.signColor,)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                popularProduct.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20 ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
                child: BigText(text: "\$ ${product.price!}" + "| Add to cart", color: Colors.white,),
              ),
            )
          ],
        ),
      );
      },)
    );
  }
}