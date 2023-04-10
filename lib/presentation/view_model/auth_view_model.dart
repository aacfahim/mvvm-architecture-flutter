import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_arch/domain/repository/auth_repo.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessage(value.toString(), context);
      // Utils.flushBarErrorMessage("Login Successfully", context);
      print(value.toString());

      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }
}
