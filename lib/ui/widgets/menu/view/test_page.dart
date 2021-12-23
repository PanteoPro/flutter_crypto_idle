import 'dart:math';

import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Page')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              _ClickableCPWidget(),
              _AnimatedSwitcherWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSwitcherWidget extends StatefulWidget {
  const _AnimatedSwitcherWidget({Key? key}) : super(key: key);

  @override
  __AnimatedSwitcherWidgetState createState() => __AnimatedSwitcherWidgetState();
}

class __AnimatedSwitcherWidgetState extends State<_AnimatedSwitcherWidget> {
  late Widget _myWidget;
  @override
  void initState() {
    super.initState();
    _myWidget = Text('HEllo', key: ValueKey<int>(1));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _myWidget = Text('now hello', key: ValueKey<int>(2));
          });
        },
        child: AnimatedSwitcher(duration: const Duration(seconds: 1), child: _myWidget));
  }
}

class _ClickableCPWidget extends StatefulWidget {
  const _ClickableCPWidget();
  @override
  State<_ClickableCPWidget> createState() => _ClickableCPWidgetState();
}

class _ClickableCPWidgetState extends State<_ClickableCPWidget> {
  final digitals = <Widget>[];

  final animationLength = 800;
  bool isStartCleaning = false;

  void _addMoney() {
    final money = Random().nextInt(20);
    final digit = _DigitalWidget(money: money);
    digitals.add(digit);
    setState(() {});
    if (isStartCleaning == false) {
      isStartCleaning = true;
      Future.delayed(Duration(seconds: 30), () {
        digitals.clear();
        isStartCleaning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _addMoney(),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              width: 200,
              height: 200,
              child: const Padding(
                padding: EdgeInsets.all(40),
                child: Placeholder(),
              ),
            ),
          ),
          SizedBox(width: 32, height: 32, child: Image.asset('assets/images/icons/computer_icon.png')),
          Positioned(
            left: 32,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset('assets/images/icons/lightning_icon.png'),
            ),
          ),
          Positioned(
            left: 80,
            child: Text(
              'Text',
              style: TextStyle(fontFamily: 'AveriaSerifLibre', fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 15,
            left: 80,
            child: Text(
              'Text',
            ),
          ),
          ...digitals,
        ],
      ),
    );
  }
}

class _DigitalWidget extends StatefulWidget {
  const _DigitalWidget({Key? key, required this.money}) : super(key: key);

  final int money;

  @override
  __DigitalWidgetState createState() => __DigitalWidgetState();
}

class __DigitalWidgetState extends State<_DigitalWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final yToMove = 300.0;
  final x = Random().nextInt(180).toDouble();
  final y = Random().nextInt(30).toDouble();
  final animationLength = 800;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationLength),
      lowerBound: y,
      upperBound: yToMove,
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      child: Text(
        '${widget.money}\$',
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontFamily: 'AveriaSerifLibre',
        ),
      ),
      bottom: animationController.value,
      left: x,
      duration: Duration(milliseconds: 0),
    );
  }
}
