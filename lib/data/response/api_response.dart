import 'package:mvvm_arch/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loadiing() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error() : status = Status.ERROR;

  // factory keyword allows for more flexibility in constructing objects
  //especially when the exact implementation details of the object creation can vary.

  // factory ApiResponse.loading() {
  //   return ApiResponse(Status.LOADING, null, null);
  // }

  // factory ApiResponse.completed(T data) {
  //   return ApiResponse(Status.COMPLETED, data, null);
  // }

  // factory ApiResponse.error(String message) {
  //   return ApiResponse(Status.ERROR, null, message);
  // }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
