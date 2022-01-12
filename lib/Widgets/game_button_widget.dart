import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

class GameButtonWidget extends StatelessWidget {
  const GameButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    required this.height,
    required this.width,
    required this.font,
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  const GameButtonWidget.white({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 32,
    this.width = 140,
    this.font = AppFonts.main,
    this.borderColor = AppColors.white,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.black50,
  }) : super(key: key);

  const GameButtonWidget.game({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 44,
    this.width = 140,
    this.font = AppFonts.mainButton,
    this.borderColor = AppColors.white,
    this.textColor = AppColors.white,
    this.backgroundColor = Colors.white24,
  }) : super(key: key);

  const GameButtonWidget.tokenSelect({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 36,
    this.width = 90,
    this.font = AppFonts.mainButton,
    this.borderColor = AppColors.green,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.mainGrey,
  }) : super(key: key);

  const GameButtonWidget.buy({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 25,
    this.width = 70,
    this.font = AppFonts.mainButton,
    this.borderColor = AppColors.green,
    this.textColor = AppColors.green,
    this.backgroundColor = AppColors.secondGrey,
  }) : super(key: key);

  const GameButtonWidget.menuSmall({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 40,
    this.width = 150,
    this.font = AppFonts.clicker,
    this.borderColor = AppColors.green,
    this.textColor = AppColors.green,
    this.backgroundColor = AppColors.mainGrey,
  }) : super(key: key);

  const GameButtonWidget.menuBig({
    Key? key,
    required this.text,
    this.onPressed,
    this.height = 40,
    this.width = 180,
    this.font = AppFonts.clicker,
    this.borderColor = AppColors.green,
    this.textColor = AppColors.green,
    this.backgroundColor = AppColors.mainGrey,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final double height;
  final double width;
  final TextStyle font;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: borderColor,
              ),
            ),
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          style: font.copyWith(color: textColor),
        ),
      ),
    );
  }
}
