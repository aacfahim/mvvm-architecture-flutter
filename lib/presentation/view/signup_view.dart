import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mvvm_arch/presentation/view_model/auth_view_model.dart';
import 'package:mvvm_arch/presentation/widgets/custom_button.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utils.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(false);

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            const SizedBox(height: 18),
            ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePassword.value,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: InkWell(
                        onTap: () {
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child: _obsecurePassword.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            CustomButton(
                title: "Sign up",
                loading: authViewModel.signUpLoading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage("Please enter email", context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter password", context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        "Password must be at least 6 digit", context);
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    authViewModel.signUpApi(data, context);
                    //print("api hit");
                  }
                }),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RoutesName.login);
                    },
                    child: const Text("Click here")),
              ],
            ),
          ],
        ));
  }
}
