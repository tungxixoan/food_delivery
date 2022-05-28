import 'package:food_delivery/data/api/api_chient.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
//5h27
class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}