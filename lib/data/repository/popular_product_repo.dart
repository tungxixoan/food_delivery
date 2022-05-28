import 'package:food_delivery/data/api/api_chient.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
//5h27
class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}