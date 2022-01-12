import 'dart:math';

import 'package:crypto_tycoon/resources/resources.dart';
import 'package:flutter/material.dart';

class CircleAnimatedBackgroundWidget extends StatefulWidget {
  const CircleAnimatedBackgroundWidget({
    Key? key,
    this.imagePath,
    this.child,
    this.size,
    this.isReverse = false,
  }) : super(key: key);
  final String? imagePath;
  final Widget? child;
  final double? size;
  final bool isReverse;

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
    return Stack(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi * (widget.isReverse ? -1 : 1),
                child: child,
              );
            },
            child: Image.asset(
              widget.imagePath ?? AppBackgroundImages.menuCircle,
              fit: BoxFit.contain,
            ),
          ),
        ),
        if (widget.child != null)
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: Center(
              child: widget.child,
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
