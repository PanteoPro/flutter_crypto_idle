import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

class CircleIndexWidget extends StatelessWidget {
  const CircleIndexWidget({Key? key, required this.index, this.color = AppColors.green}) : super(key: key);

  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final currentIndex = index + 1;
    final countX = currentIndex ~/ 10;
    final countV = (currentIndex - countX * 10) ~/ 5;
    final countI = currentIndex - countX * 10 - countV * 5;
    var style = AppFonts.body.copyWith(color: color);

    var text = StringBuffer();
    for (int i = 0; i < countX; i++) {
      text.write('X');
    }
    for (int i = 0; i < countV; i++) {
      text.write('V');
    }
    for (int i = 0; i < countI; i++) {
      text.write('I');
    }

    final toLowerFont = ['VIII', 'VIIII', 'XIII', 'XIIII', 'XVI', 'XVII', 'XVIII'];
    if (toLowerFont.contains(text.toString())) {
      style = AppFonts.body2.copyWith(color: color);
    }

    return SizedBox(
      width: 20,
      height: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: Center(
          child: Text(
            text.toString(),
            style: style,
          ),
        ),
      ),
    );
  }
}
