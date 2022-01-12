import 'dart:math';

import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  const RadialPercentWidget({
    Key? key,
    required this.child,
    required this.percent,
    required this.lineColor,
    required this.maxLineColor,
    required this.text,
    this.fillColor = Colors.transparent,
    this.lineWidth = 3,
    this.freeColor = Colors.transparent,
    this.freeLineWidth = 0,
    this.padding = 0,
    this.paddingForChild = 10,
    this.left = 20,
    this.bottom = 10,
  }) : super(key: key);

  final Widget child;
  final double percent;

  /// Background cirlce color
  final Color fillColor;

  /// Start color when 0%
  final Color lineColor;

  /// End color then 100%
  final Color maxLineColor;
  final Color freeColor;
  final double lineWidth;
  final double freeLineWidth;

  final double padding;
  final double paddingForChild;

  /// Text around cirlce
  final String text;

  /// for text position
  final double left;

  /// for text position
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final paddingForChildT = (padding + lineWidth) * 2 + paddingForChild;
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent,
            fillColor: fillColor,
            lineColor: lineColor,
            freeColor: freeColor,
            lineWidth: lineWidth,
            freeLineWidth: freeLineWidth,
            maxLineColor: maxLineColor,
            padding: padding,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(paddingForChildT),
          child: Center(child: child),
        ),
        Positioned(
          left: left,
          bottom: bottom,
          child: Text(
            text,
            style: AppFonts.clicker.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color maxLineColor;
  final Color freeColor;
  final double lineWidth;
  final double freeLineWidth;
  final double padding;

  const MyPainter({
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.maxLineColor,
    required this.freeColor,
    required this.lineWidth,
    required this.freeLineWidth,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = calculateArcRect(size);

    drawBackground(canvas, size);
    drawFreeLine(canvas, arcRect);
    drawFillLine(canvas, arcRect);
  }

  void drawFreeLine(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = freeLineWidth;
    paint.isAntiAlias = true;
    paint.strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      2 * pi * percent - (pi / 2),
      2 * pi * (1 - percent),
      false,
      paint,
    );
  }

  Color calculateColor() {
    final difRed = (lineColor.red - maxLineColor.red).abs();
    final difGreen = (lineColor.green - maxLineColor.green).abs();
    final difBlue = (lineColor.blue - maxLineColor.blue).abs();

    final calcRed = lineColor.red > maxLineColor.red
        ? lineColor.red - (difRed * percent).toInt()
        : lineColor.red + (difRed * percent).toInt();

    final calcGreen = lineColor.green > maxLineColor.green
        ? lineColor.green - (difGreen * percent).toInt()
        : lineColor.green + (difGreen * percent).toInt();

    final calcBlue = lineColor.blue > maxLineColor.blue
        ? lineColor.blue - (difBlue * percent).toInt()
        : lineColor.blue + (difBlue * percent).toInt();

    Color color = Color.fromRGBO(calcRed, calcGreen, calcBlue, 1);
    return color;
  }

  void drawFillLine(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = calculateColor();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.isAntiAlias = true;
    paint.strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      6.75 * pi / 8,
      1.8 * pi * percent,
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcRect(Size size) {
    final offset = lineWidth / 2 + padding;
    final arcOffset = Offset(offset, offset);
    final arcSize = Size(size.width - offset * 2, size.height - offset * 2);
    final arcRect = arcOffset & arcSize;
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
