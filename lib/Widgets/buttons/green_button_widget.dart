import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

class GreenButtonWidget extends StatelessWidget {
  const GreenButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.green,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.secondGrey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: color,
              ),
            ),
          ),
        ),
        child: Text(
          text,
          style: AppFonts.main.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
