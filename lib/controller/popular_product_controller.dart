import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

//5h37
class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
   
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  
  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem+_quantity;
  


  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      // print("got data");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); 
    }else{

    }
  }
  
  void setQuantity(bool isIncrement) {
    if(isIncrement ){
      
      _quantity = checkQuantity(_quantity+1);
      print("inscrement"+_quantity.toString());
    }else{
      
      _quantity = checkQuantity(_quantity-1);
       print("decrement"+_quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItem+ quantity) <0){
      Get.snackbar("Item count!", "You can't reduce more!", backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      if (_inCartItem>0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem+ quantity) >20){
       Get.snackbar("Item count!", "You can't add more!", backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(ProductModel product, CartController cart){ // Đảm bảo khi đổi mỗi  page food khác nhau thì số lượng ở mỗi page đề bắt đầu từ 0
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print("exist or not "+exist.toString());
    if (exist) {
      _inCartItem=_cart.getQuantity(product);
    }
    print("the quantity in the cart is " +_inCartItem.toString());

  }
  void addItem(ProductModel product){
    // if(_quantity>0){
       _cart.addItem(product, _quantity);
       _quantity = 0;
       _inCartItem = _cart.getQuantity(product);
       _cart.item.forEach((key, value) {
         print("the id is "+ value.id.toString()+" The quantity is " + value.quantity.toString());
       });
    // }else{
    //    Get.snackbar("Item count!", "You should at least add an item in the cart", backgroundColor: AppColors.mainColor,
    //   colorText: Colors.white);
    // }//9h00
    update();
  }
  
  int get totalItems{
    return _cart.totalItems;
    // update();
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
  
}
