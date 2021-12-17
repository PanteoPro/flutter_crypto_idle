part of '../new_main_game_page.dart';

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            children: const [
              _CirlceWidget(),
              SizedBox(height: 30),
              _ActionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CirlceWidget extends StatefulWidget {
  const _CirlceWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_CirlceWidget> createState() => _CirlceWidgetState();
}

class _CirlceWidgetState extends State<_CirlceWidget> {
  double value = 1.0;

  final digitals = <Widget>[];
  final animationLength = 800;
  bool isStartCleaning = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _addMoney,
            child: SizedBox(
              width: 170,
              height: 170,
              child: RadialPercentWidget(
                percent: value,
                lineColor: Color.fromRGBO(217, 0, 0, 1),
                maxLineColor: Color.fromRGBO(0, 210, 149, 1),
                lineWidth: 2,
                padding: 10,
                child: Image.asset(AppImages.image_comp_tap),
                // text: '${(value * 100).toInt()}',
                text: '${(value * 500).toInt()} ',
                left: 10,
              ),
            ),
          ),
          ...digitals,
        ],
      ),
    );
  }

  void _tap() {
    value -= 0.002;
    setState(() {});
  }

  void _addMoney() {
    _tap();
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
}

class _DigitalWidget extends StatefulWidget {
  const _DigitalWidget({Key? key, required this.money}) : super(key: key);

  final int money;

  @override
  __DigitalWidgetState createState() => __DigitalWidgetState();
}

class __DigitalWidgetState extends State<_DigitalWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final yToMove = 200.0;
  final x = Random().nextInt(140).toDouble();
  final y = Random().nextInt(20).toDouble();
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
      child: Text('${widget.money}\$', style: TextStyle(color: Color.fromRGBO(0, 210, 149, 1))),
      bottom: animationController.value,
      left: x,
      duration: Duration(milliseconds: 0),
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionItemWidget(
                title: 'Купить установки',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _ActionItemWidget(
                title: 'Купить помещение',
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _ActionItemWidget(
                title: 'Криптовалюта',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _ActionItemWidget(
                title: 'Статистика',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionItemWidget extends StatelessWidget {
  const _ActionItemWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: Theme.of(context).hintColor,
                width: 2.0,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
