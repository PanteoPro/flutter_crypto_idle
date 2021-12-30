part of '../../main_game_page.dart';

GlobalKey _globalKeyCircleWidget = GlobalKey();

class _ClickerWidget extends StatelessWidget {
  const _ClickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: _ClickerUpgradeWidget(),
          ),
          _CirlceWidget(key: _globalKeyCircleWidget),
          // const Expanded(
          //   child: _ClickerInfoWidget(),
          // ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _ClickerInfoWidget extends StatefulWidget {
  const _ClickerInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_ClickerInfoWidget> createState() => _ClickerInfoWidgetState();
}

class _ClickerInfoWidgetState extends State<_ClickerInfoWidget> {
  double height = 0.0;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      height = _globalKeyCircleWidget.currentContext!.size!.height;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClickerGameViewModel>();
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${S.of(context).game_main_upgrade_info_title}:',
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
          Text(
            '${S.of(context).game_main_upgrade_info_min} ${vm.state.clicker.minMoney}\$',
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
          Text(
            '${S.of(context).game_main_upgrade_info_max} ${vm.state.clicker.maxMoney}\$',
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
          Text(
            '${S.of(context).game_main_upgrade_info_critical} ${vm.state.clicker.critMoney}\$',
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
          Text(
            '${S.of(context).game_main_upgrade_info_critical_probability} ${(vm.state.clicker.probabilityCrit * 100).toStringAsFixed(0)}%',
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _ClickerUpgradeWidget extends StatefulWidget {
  const _ClickerUpgradeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_ClickerUpgradeWidget> createState() => _ClickerUpgradeWidgetState();
}

class _ClickerUpgradeWidgetState extends State<_ClickerUpgradeWidget> {
  double height = 0.0;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      height = _globalKeyCircleWidget.currentContext!.size!.height;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clickerVM = context.watch<ClickerGameViewModel>();
    final money = context.select((MainGameViewModel vm) => vm.state.money);
    final isCanUpgrade = money >= clickerVM.state.clicker.upgradeCost;
    final isMaxLevel = clickerVM.state.clicker.level == clickerVM.state.clicker.maxLevel;
    final textMaxLevel = isMaxLevel ? '${S.of(context).game_main_upgrade_info_max} ' : '';
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isMaxLevel)
            Text(
              S.of(context).game_main_upgrade_title,
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
          if (!isMaxLevel) const SizedBox(height: 4),
          if (!isMaxLevel)
            GestureDetector(
              onTap: clickerVM.onOpenModal,
              child:
                  Image.asset(isCanUpgrade ? AppIconsImages.upgrade : AppIconsImages.noUpgrade, width: 32, height: 32),
            ),
          if (!isMaxLevel) const SizedBox(height: 4),
          Text(
            '$textMaxLevel${S.of(context).game_main_upgrade_level}: ${clickerVM.state.clicker.level}',
            style: AppFonts.body2.copyWith(color: AppColors.white),
          ),
        ],
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
  var _isStartToClean = false;
  double padding = 20;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ClickerGameViewModel>();
    final percentCurrentClicks = context.select((ClickerGameViewModel vm) => vm.state.percentCurrentClicks);
    final currentClicks = vm.state.clicker.currentClicks;

    final percentCurrentDelay = context.select((ClickerGameViewModel vm) => vm.state.percentCurrentDelay);
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
                  ? const CircularProgressIndicator(color: AppColors.green, strokeWidth: 2)
                  : RadialPercentWidget(
                      percent: currentClicks > 0 ? percentCurrentClicks : percentCurrentDelay,
                      lineColor: AppColors.red,
                      maxLineColor: AppColors.dollar,
                      lineWidth: 2,
                      paddingForChild: padding,
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

  Future<void> _addMoney(ClickerGameViewModel vm) async {
    final rndMoney = vm.state.getRandomMoney();
    final isAddMoney = await vm.onClickerPcPressed(rndMoney);
    final isCritical = rndMoney == vm.state.clicker.critMoney;

    if (isAddMoney) {
      _tappedAnimate();
      _addDigit(isCritical, rndMoney);
    } else if (!_isStartToClean) {
      _tappedAnimate();
      _addDigit(isCritical, rndMoney);
      _cleanDigits();
    } else {}
  }

  void _tappedAnimate() {
    padding = 25;
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        padding = 20;
      });
    });
  }

  void _cleanDigits() {
    _isStartToClean = true;
    Future.delayed(const Duration(seconds: 2), () {
      digitals.clear();
    });
  }

  void _addDigit(bool isCritical, double rndMoney) {
    _isStartToClean = false;
    final color = isCritical ? AppColors.red : AppColors.dollar;
    final textStyle = isCritical ? AppFonts.critical : AppFonts.body;
    final speed = isCritical ? 1500 : 800;

    final digit = _DigitalWidget(money: rndMoney, color: color, textStyle: textStyle, speed: speed);

    setState(() {
      digitals.add(digit);
    });
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
