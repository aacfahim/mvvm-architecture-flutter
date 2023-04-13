import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_arch/data/model/user_model.dart';
import 'package:mvvm_arch/domain/repository/auth_repo.dart';
import 'package:mvvm_arch/presentation/view_model/user_view_model.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool _signUploading = false;

  bool get loading => _loading;
  bool get signUpLoading => _signUploading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignUpLoading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(token: value['token '].toString()),
      );

      if (value.toString().contains("token")) {
        Utils.flushBarErrorMessage(" Successfully", context);
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        Utils.flushBarErrorMessage(value.toString(), context);
      }
      print(value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setsignUpLoading(true);
    _myRepo.signUpApi(data).then((value) {
      setsignUpLoading(false);
      //Utils.flushBarErrorMessage(value.toString(), context);

      if (value.toString().contains("token")) {
        Utils.flushBarErrorMessage("Registration Successfully", context);
        Navigator.pushNamed(context, RoutesName.home);
      } else {
        Utils.flushBarErrorMessage(value.toString(), context);
      }
      print(value.toString());
    }).onError((error, stackTrace) {
      setsignUpLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
  }
}
