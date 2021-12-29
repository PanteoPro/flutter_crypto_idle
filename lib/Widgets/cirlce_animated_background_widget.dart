import 'dart:math';

import 'package:crypto_idle/resources/resources.dart';
import 'package:flutter/material.dart';

class CircleAnimatedBackgroundWidget extends StatefulWidget {
  const CircleAnimatedBackgroundWidget({Key? key}) : super(key: key);

  @override
  _CircleAnimatedBackgroundWidgetState createState() => _CircleAnimatedBackgroundWidgetState();
}

class _CircleAnimatedBackgroundWidgetState extends State<CircleAnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: Image.asset(
        AppBackgroundImages.menuCircle,
        fit: BoxFit.contain,
      ),
    );
  }
}
