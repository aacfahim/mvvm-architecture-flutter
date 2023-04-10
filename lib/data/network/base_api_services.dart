import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mvvm_arch/data/app_exceptions.dart';
import 'package:mvvm_arch/data/network/network_api_services.dart';
import 'package:mvvm_arch/utils/app_url.dart';
import 'package:mvvm_arch/utils/utils.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      return FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        return BadRequestException(response.body.toString());
      case 404:
        return BadRequestException(response.body.toString());
      case 500:
        return BadRequestException(response.body.toString());
      default:
        return FetchDataException(
            "Error occured while communicating with server with status code: " +
                response.statusCode.toString());
    }
  }
}
