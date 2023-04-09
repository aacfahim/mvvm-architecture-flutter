import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_arch/repository/auth_repo.dart';
import 'package:mvvm_arch/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo.loginApi(data).then((value) {
      Utils.flushBarErrorMessage(value.toString(), context);
      print(value.toString());
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString() + "hello");
    });
  }
}
