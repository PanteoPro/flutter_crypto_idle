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
            SizedBox(height: 20),
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
                  ? const CircularProgressIndicator(color: AppColors.green)
                  : RadialPercentWidget(
                      percent: currentClicks > 0 ? percentCurrentClicks : percentCurrentDelay,
                      lineColor: AppColors.red,
                      maxLineColor: AppColors.green,
                      lineWidth: 2,
                      paddingForChild: 15,
                      text: currentClicks > 0 ? '$currentClicks' : delayText,
                      left: currentClicks > 0 ? 10 : 5,
                      child: Image.asset(AppImages.imageCompTap),
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
    final isCritical = rndMoney == MainGameViewModel.critRandomMoney;

    if (isAddMoney) {
      final color = isCritical ? AppColors.red : AppColors.dollar;
      final textStyle = isCritical ? AppFonts.critical : AppFonts.body;
      final speed = isCritical ? 1500 : 800;

      final digit = _DigitalWidget(money: rndMoney, color: color, textStyle: textStyle, speed: speed);

      setState(() {
        digitals.add(digit);
      });
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
    required this.textStyle,
    required this.speed,
  }) : super(key: key);

  final double money;
  final Color color;
  final int speed;
  final TextStyle textStyle;

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
        style: widget.textStyle.copyWith(color: widget.color),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionItemWidget(
                title: 'Купить установки',
                onPressed: () => vm.onBuyPcButtonPressed(context),
              ),
              const SizedBox(width: 12),
              _ActionItemWidget(
                title: 'Купить помещение',
                onPressed: () => vm.onBuyFlatButtonPressed(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionItemWidget(
                title: 'Криптовалюта',
                onPressed: () => vm.onWalletButtonPressed(context),
              ),
              const SizedBox(width: 12),
              _ActionItemWidget(
                title: 'Статистика',
                onPressed: () => vm.onStatisticButtonPressed(context),
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
      height: 32,
      width: 100,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.mainGrey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(
                color: AppColors.green,
              ),
            ),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 9, horizontal: 10)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppFonts.mainButton.copyWith(color: AppColors.green),
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
      height: 150,
      child: ColoredBox(
        color: AppColors.secondGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ListView.separated(
            itemCount: countPC,
            itemBuilder: (context, index) {
              return _ComputerItemWidget(index: index);
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
          ),
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
    final pc = context.read<MainGameViewModel>().state.myPCs[index];
    return SizedBox(
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.green),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              __ComputerItemIndexWidget(index: index),
              const SizedBox(width: 4),
              Image.asset(
                AppImages.getPcPathByName(pc.name),
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 4),
              Text(
                pc.name,
                style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
              ),
              const Spacer(),
              __ComputerItemImageCryptoWidget(index: index),
              __ComputerItemButtonOrMiningWidget(index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class __ComputerItemIndexWidget extends StatelessWidget {
  const __ComputerItemIndexWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final currentIndex = index + 1;
    final countX = currentIndex ~/ 10;
    final countV = (currentIndex - countX * 10) ~/ 5;
    final countI = currentIndex - countX * 10 - countV * 5;
    var style = AppFonts.body.copyWith(color: AppColors.green);

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
      style = AppFonts.body2.copyWith(color: AppColors.green);
    }

    return SizedBox(
      width: 20,
      height: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.green),
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

class __ComputerItemImageCryptoWidget extends StatelessWidget {
  const __ComputerItemImageCryptoWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.myPCs[index].miningToken);
    final pc = context.read<MainGameViewModel>().state.myPCs[index];

    final imagePath =
        pc.miningToken == null ? AppImages.iconEmpty : AppImages.getTokenPathBySymbol(pc.miningToken!.symbol);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: Image.asset(
        imagePath,
        width: 28,
        height: 28,
      ),
    );
  }
}

class __ComputerItemButtonOrMiningWidget extends StatelessWidget {
  const __ComputerItemButtonOrMiningWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.myPCs[index].miningToken);
    final pc = context.read<MainGameViewModel>().state.myPCs[index];

    Widget widget = Text(
      pc.miningToken?.symbol ?? 'НАЗНАЧИТЬ',
      style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
    );
    if (pc.miningToken == null) {
      widget = TextButton(
        onPressed: () {},
        child: Text(
          'НАЗНАЧИТЬ',
          style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
        ),
      );
    }
    return widget;
  }
}

class _OLDComputerItemWidget extends StatelessWidget {
  const _OLDComputerItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.myPCs[index].miningToken);
    final pc = context.read<MainGameViewModel>().state.myPCs[index];
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
                        : AppImages.iconEmpty,
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
            style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
          )
        ],
      ),
    );
  }
}
