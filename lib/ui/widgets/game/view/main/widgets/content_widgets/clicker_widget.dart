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
          const Expanded(
            child: _RewardAdWidget(),
          ),
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
  Stream<dynamic>? _streamRewardTimer;
  Stream<dynamic>? _streamReward;
  StreamSubscription<dynamic>? _streamRewardTimerSubscription;
  StreamSubscription<dynamic>? _streamRewardSubscription;
  int currentSeconds = 0;
  int rewardSeconds = 0;

  final digitals = <Widget>[];
  final animationLength = 800;
  var _isStartToClean = false;
  double padding = 20;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final vm = context.read<ClickerGameViewModel>();
    final isReward = context.watch<ClickerGameViewModel>().state.isReward;
    if (isReward) {
      _startMoneyReward(vm);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ClickerGameViewModel>();
    final percentCurrentClicks = context.select((ClickerGameViewModel vm) => vm.state.percentCurrentClicks);
    final currentClicks = vm.state.clicker.currentClicks;

    final percentCurrentDelay = context.select((ClickerGameViewModel vm) => vm.state.percentCurrentDelay);
    final delayText = vm.state.currentDelayString;

    final isNoData = percentCurrentClicks == 0 && percentCurrentDelay == 1;

    final rewardSecondsVMText = ClickerGameViewModelState.secondsToString(rewardSeconds - currentSeconds);

    // if (isReward) {
    //   _startMoneyReward(vm);
    // }

    final percent = _streamRewardSubscription != null
        ? (rewardSeconds - currentSeconds) / rewardSeconds
        : currentClicks > 0
            ? percentCurrentClicks
            : percentCurrentDelay;
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _streamRewardSubscription != null ? null : () => _addMoney(vm),
            child: SizedBox(
              width: 170,
              height: 170,
              child: isNoData
                  ? const CircularProgressIndicator(color: AppColors.green, strokeWidth: 2)
                  : RadialPercentWidget(
                      percent: percent,
                      lineColor: AppColors.red,
                      maxLineColor: AppColors.dollar,
                      lineWidth: 2,
                      paddingForChild: padding,
                      text: _streamRewardSubscription != null
                          ? rewardSecondsVMText
                          : currentClicks > 0
                              ? '$currentClicks'
                              : delayText,
                      left: currentClicks > 0 ? 10 : 5,
                      child: Image.asset(AppImages.imageCompTap),
                    ),
            ),
          ),
          // const Positioned(
          //   right: 0,
          //   top: 0,
          //   child: _RewardAdWidget(),
          // ),
          ...digitals,
        ],
      ),
    );
  }

  void _startMoneyReward(ClickerGameViewModel vm) {
    if (_streamReward == null) {
      currentSeconds = 0;
      rewardSeconds = vm.state.rewardSeconds;

      _streamRewardTimer = Stream.periodic(const Duration(seconds: 1));
      _streamRewardTimerSubscription = _streamRewardTimer?.listen((event) {
        currentSeconds++;
        setState(() {});
      });
      _streamReward = Stream.periodic(const Duration(milliseconds: 300));
      _streamRewardSubscription = _streamReward?.listen((event) {
        _addMoneyReward(vm);
      });
      Future.delayed(Duration(seconds: rewardSeconds), () {
        _streamRewardSubscription?.cancel();
        _streamRewardTimerSubscription?.cancel();
        _streamReward = null;
        _streamRewardTimer = null;
        _streamRewardSubscription = null;
        _streamRewardTimerSubscription = null;
        vm.onUseReward();
        _cleanDigits();
      });
    }
  }

  Future<void> _addMoneyReward(ClickerGameViewModel vm) async {
    final rndMoney = vm.state.getRandomMoney();
    final isCritical = rndMoney == vm.state.clicker.critMoney;
    await vm.rewardGetMoney(rndMoney);
    _tappedAnimate();
    _addDigit(isCritical, rndMoney);
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

class _RewardAdWidget extends StatefulWidget {
  const _RewardAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RewardAdWidget> createState() => _RewardAdWidgetState();
}

class _RewardAdWidgetState extends State<_RewardAdWidget> {
  static final AdRequest request = AdRequest(
      // keywords: <String>['foo', 'bar'],
      // contentUrl: 'http://foo.com/bar.html',
      // nonPersonalizedAds: true,
      );

  final int maxFailedLoadAttempts = 3;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-7838430906859541/4736119101',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            // print('$ad loaded.');
            _rewardedAd = ad;
            setState(() {});
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            setState(() {});
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            } else {
              Future.delayed(const Duration(seconds: 60), () {
                _createRewardedAd();
              });
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      // print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      // onAdShowedFullScreenContent: (RewardedAd ad) => print('???????????? ?????????????? -----------------------.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        // print('?????????????? ?????????????? -----------------------');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        // print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reward ${reward.amount} ${reward.type}'),
        ),
      );
      context.read<ClickerGameViewModel>().onGetReward(reward.amount as int);
      // print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
    _rewardedAd?.dispose();
  }

  void testReward() {
    context.read<ClickerGameViewModel>().onGetReward(10);
  }

  @override
  Widget build(BuildContext context) {
    final isReward = context.select((ClickerGameViewModel vm) => vm.state.isReward);
    final isActive = _rewardedAd != null && isReward == false;
    return GestureDetector(
      onTap: isActive ? _showRewardedAd : null,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: isActive ? [AppColors.green, AppColors.green] : [AppColors.grey, AppColors.grey],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(AppIconsImages.tv),
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).game_main_ads_title,
            style: AppFonts.body.copyWith(color: isActive ? AppColors.white : AppColors.grey),
          ),
        ],
      ),
    );
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
