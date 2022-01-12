import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class MySwitcher extends StatefulWidget {
  const MySwitcher({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 40,
    this.height = 18,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  @override
  _MySwitcherState createState() => _MySwitcherState();
}

class _MySwitcherState extends State<MySwitcher> with SingleTickerProviderStateMixin {
  late Animation<Alignment> _circleAnimation;
  late AnimationController _animationController;

  void _initAnimation() {
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(CurvedAnimation(curve: Curves.linear, parent: _animationController));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 160),
    );
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant MySwitcher oldWidget) {
    // _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: _animateMethod,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.width / 2),
              color: _circleAnimation.value == Alignment.centerLeft ? AppColors.mainGrey : AppColors.green,
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Align(
              alignment: _circleAnimation.value,
              child: SizedBox(
                height: widget.height - 2,
                width: widget.height - 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular((widget.height - 2) / 2),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _animateMethod() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
  }
}
