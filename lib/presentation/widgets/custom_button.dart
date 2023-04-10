import 'package:flutter/material.dart';
import 'package:mvvm_arch/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.loading = false,
      required this.title,
      required this.onPress});

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 40,
        // width: 100,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: Center(
            child: loading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25),
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Text(title,
                    style: const TextStyle(color: AppColors.whiteColor))),
      ),
    );
  }
}
