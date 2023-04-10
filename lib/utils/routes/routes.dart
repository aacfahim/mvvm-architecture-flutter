import 'package:flutter/material.dart';
import 'package:mvvm_arch/presentation/view/signup_view.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/presentation/view/home_view.dart';
import 'package:mvvm_arch/presentation/view/login_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeView());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpView());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
