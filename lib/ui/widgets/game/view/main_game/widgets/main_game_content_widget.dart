part of '../new_main_game_page.dart';

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: const [
            _CirlceWidget(),
            SizedBox(height: 30),
            _ActionsWidget(),
            SizedBox(height: 30),
            Spacer(),
            _ComputersWidget(),
          ],
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
  final digitals = <Widget>[];
  final animationLength = 800;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final percentCurrentClicks = context.select((MainGameViewModel vm) => vm.state.percentCurrentClicks);
    final currentClicks = vm.state.currentClicks;

    final percentCurrentDelay = context.select((MainGameViewModel vm) => vm.state.percentCurrentDelay);
    final delayText = vm.state.currentDelayString;

    final isNoData = percentCurrentClicks == 0 && percentCurrentDelay == 1;
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _addMoney(vm),
            child: SizedBox(
              width: 170,
              height: 170,
              child: isNoData
                  ? CircularProgressIndicator(color: Theme.of(context).hintColor)
                  : RadialPercentWidget(
                      percent: currentClicks > 0 ? percentCurrentClicks : percentCurrentDelay,
                      lineColor: const Color.fromRGBO(217, 0, 0, 1),
                      maxLineColor: const Color.fromRGBO(0, 210, 149, 1),
                      lineWidth: 2,
                      padding: 10,
                      text: currentClicks > 0 ? '$currentClicks' : delayText,
                      left: currentClicks > 0 ? 10 : 5,
                      child: Image.asset(AppImages.image_comp_tap),
                    ),
            ),
          ),
          ...digitals,
        ],
      ),
    );
  }

  Future<void> _addMoney(MainGameViewModel vm) async {
    final rndMoney = MainGameViewModel.getRandomMoney();
    final isAddMoney = await vm.onClickerPcPressed(rndMoney);

    if (isAddMoney) {
      final color = rndMoney == MainGameViewModel.critRandomMoney
          ? const Color.fromRGBO(217, 0, 0, 1)
          : const Color.fromRGBO(0, 210, 149, 1);
      final speed = rndMoney == MainGameViewModel.critRandomMoney ? 1500 : 800;
      final digit = _DigitalWidget(money: rndMoney, color: color, speed: speed);
      digitals.add(digit);
      setState(() {});
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        digitals.clear();
      });
    }
  }
}

class _DigitalWidget extends StatefulWidget {
  const _DigitalWidget({
    Key? key,
    required this.money,
    required this.color,
    required this.speed,
  }) : super(key: key);

  final double money;
  final Color color;
  final int speed;

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
      duration: Duration(milliseconds: widget.speed),
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
      bottom: animationController.value,
      left: x,
      duration: Duration.zero,
      child: Text(
        '${widget.money}\$',
        style: TextStyle(color: widget.color),
      ),
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: _ActionItemWidget(
                  title: 'Купить установки',
                  onPressed: () => vm.onBuyPcButtonPressed(context),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _ActionItemWidget(
                  title: 'Купить помещение',
                  onPressed: () => vm.onBuyFlatButtonPressed(context),
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
                  onPressed: () => vm.onWalletButtonPressed(context),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _ActionItemWidget(
                  title: 'Статистика',
                  onPressed: () => vm.onStatisticButtonPressed(context),
                ),
              ),
            ],
          ),
        ],
      ),
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

class _ComputersWidget extends StatelessWidget {
  const _ComputersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countPC = context.select((MainGameViewModel vm) => vm.state.myPCs.length);
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ColoredBox(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              itemCount: countPC,
              itemBuilder: (context, index) {
                return _ComputerItemWidget(index: index);
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(width: 10);
              }),
        ),
      ),
    );
  }
}

class _ComputerItemWidget extends StatelessWidget {
  const _ComputerItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.select((MainGameViewModel vm) => vm.state.myPCs[index]);
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AppImages.getPcPathByName(pc.name),
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                right: 5,
                bottom: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    pc.miningToken != null
                        ? AppImages.getTokenPathBySymbol(pc.miningToken!.symbol)
                        : AppImages.icon_empty,
                    height: 24,
                    width: 24,
                  ),
                ),
              )
            ],
          ),
          Text(
            pc.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
