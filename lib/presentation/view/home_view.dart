import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_arch/presentation/view_model/user_view_model.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                userPreference.remove().then((value) {
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                });
              },
              child: const Text("Logout")),
        ],
      ),
    );
  }
}
