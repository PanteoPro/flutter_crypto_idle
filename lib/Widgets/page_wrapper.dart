import 'package:crypto_idle/Widgets/game_over_modal.dart';
import 'package:flutter/material.dart';

class PageWrapperWidget extends StatelessWidget {
  const PageWrapperWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const GameOverModalWidget(),
      ],
    );
  }
}
