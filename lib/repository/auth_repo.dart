import 'package:mvvm_arch/data/network/base_api_services.dart';
import 'package:mvvm_arch/data/network/network_api_services.dart';
import 'package:mvvm_arch/utils/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);

      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> registrationApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
