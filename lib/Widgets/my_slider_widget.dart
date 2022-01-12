import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class MySliderWidget extends StatelessWidget {
  const MySliderWidget({
    Key? key,
    required this.value,
    required this.callback,
    this.activeColor = AppColors.green,
    this.circleColor = AppColors.green,
    this.leftPaddings = 10,
  }) : super(key: key);

  final double value;
  final Function(double) callback;
  final Color activeColor;
  final Color circleColor;
  final double leftPaddings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: SliderTheme(
        data: SliderThemeData(
          trackShape: TrackShapeSlider(leftPaddings: leftPaddings),
          thumbColor: circleColor,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          activeTrackColor: activeColor,
          inactiveTrackColor: AppColors.grey,
        ),
        child: Slider(
          value: value,
          onChanged: callback,
        ),
      ),
    );
  }
}

class TrackShapeSlider extends RoundedRectSliderTrackShape {
  TrackShapeSlider({
    this.leftPaddings = 10,
  });

  final double leftPaddings;

  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 1;
    final double trackLeft = offset.dx + leftPaddings;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - leftPaddings * 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
