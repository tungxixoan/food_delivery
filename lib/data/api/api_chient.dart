import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart'; 
//5h10
class ApiClient extends GetConnect implements GetxService{

  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){ // Mỗi khi API Client giao tiếp với Server thi nó cần phải đề cập tiêu đề_[Headers] trong URL, 
                                         // và đó là lí do khởi tạo tiêu đề này bất kể là GET hay POST 
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;

    _mainHeaders={
      'Content-type'  : 'application/json; charset=UTF-8', // Nếu muốn nhận phản hồi từ Server cũng nên chuẩn bị một tiêu đề đơn giản
      'Authorization': 'Bearer $token',
    };
  }
  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}