import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_arch/data/model/user_model.dart';
import 'package:mvvm_arch/presentation/view_model/user_view_model.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      print(value.token);
      if (value.token == "null" || value.token == '') {
        await Future.delayed(const Duration(seconds: 2));
        await Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      throw error.toString();
    });
  }
}
