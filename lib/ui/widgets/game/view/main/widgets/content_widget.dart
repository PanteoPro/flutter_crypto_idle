part of '../main_game_page.dart';

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            const _ContentBackgroundImageWidget(),
            Column(
              children: const [
                SizedBox(height: 20),
                _ClickerWidget(),
                SizedBox(height: 30),
                _ActionsWidget(),
                SizedBox(height: 30),
                Spacer(),
                _ComputersWidget(),
              ],
            ),
            const _NewsOlderNewsWidget(),
          ],
        ),
      ),
    );
  }
}

class _ContentBackgroundImageWidget extends StatelessWidget {
  const _ContentBackgroundImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flat = context.select((MainGameViewModel vm) => vm.state.flat);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            AppImages.getFlatPathByName(flat.name),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(
            color: AppColors.mainGrey.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _ClickerWidget extends StatelessWidget {
  const _ClickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: _ClickerUpgradeWidget(),
          ),
          _CirlceWidget(),
          Expanded(
            child: _ClickerInfoWidget(),
          ),
        ],
      ),
    );
  }
}

class _ClickerInfoWidget extends StatelessWidget {
  const _ClickerInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClickerGameViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Денег за клик:',
          style: AppFonts.body.copyWith(color: AppColors.white),
        ),
        Text(
          'Мин ${vm.state.clicker.minMoney}\$',
          style: AppFonts.body.copyWith(color: AppColors.white),
        ),
        Text(
          'Макс ${vm.state.clicker.maxMoney}\$',
          style: AppFonts.body.copyWith(color: AppColors.white),
        ),
        Text(
          'Крит ${vm.state.clicker.critMoney}\$',
          style: AppFonts.body.copyWith(color: AppColors.white),
        ),
        Text(
          'Крит ${(vm.state.clicker.probabilityCrit * 100).toStringAsFixed(0)}%',
          style: AppFonts.body.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _ClickerUpgradeWidget extends StatelessWidget {
  const _ClickerUpgradeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClickerGameViewModel>();
    return Column(
      children: [
        Text(
          'Уровень ${vm.state.clicker.level}',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
        GestureDetector(
          onTap: () => vm.onClickUpgradeButton(),
          child: Image.asset(AppIconsImages.upIcon, width: 32, height: 32),
        ),
        Text(
          'Улучшение',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
        Text(
          'Стоимость ${S.of(context).text_with_dollar(vm.state.clicker.upgradeCost.toStringAsFixed(2))}',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _NewsOlderNewsWidget extends StatelessWidget {
  const _NewsOlderNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = context.select((DayStreamViewModel vm) => vm.newsListToDisplay);
    final newsToDisplay = news.sublist(min(1, news.length), min(4, news.length));
    final isShowNews = context.select((MainGameViewModel vm) => vm.state.isShowNews);

    return AnimatedSize(
      alignment: isShowNews ? Alignment.center : AlignmentDirectional.topCenter,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: ColoredBox(
        color: AppColors.black80,
        child: ConstrainedBox(
          constraints: !isShowNews ? const BoxConstraints(maxHeight: 0) : const BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final news in newsToDisplay) ...[_NewsOlderItemWidget(news: news), const SizedBox(height: 6)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewsOlderItemWidget extends StatelessWidget {
  const _NewsOlderItemWidget({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final stringDate = format.format(news.date);
    // SchedulerBinding.instance
    //     ?.addPostFrameCallback((_) => context.read<MainGameViewModel>().postFrameCallbackOlderNews(context));
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(double.infinity, 28)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 78,
            child: Padding(
              padding: const EdgeInsets.only(right: 4, top: 2),
              child: Text(
                stringDate,
                textAlign: TextAlign.right,
                style: AppFonts.dataNews.copyWith(color: AppColors.grey),
              ),
            ),
          ),
          Expanded(
            child: Text(
              news.text,
              style: AppFonts.mainPagePc.copyWith(color: AppColors.lightGrey),
              maxLines: 2,
            ),
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

    _tappedAnimate();

    if (isAddMoney) {
      _addDigit(isCritical, rndMoney);
    } else if (!_isStartToClean) {
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
    return GameButtonWidget.game(text: title, onPressed: onPressed);
  }
}

class _ComputersWidget extends StatefulWidget {
  const _ComputersWidget({Key? key}) : super(key: key);

  @override
  State<_ComputersWidget> createState() => _ComputersWidgetState();
}

class _ComputersWidgetState extends State<_ComputersWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final countPC = context.select((MainGameViewModel vm) => vm.state.myPCs.length);

    const heightItemComp = 36;
    const heightSizedBox = 10;
    var height = 0.0;
    if (countPC > 0) {
      final count = min(countPC, 3);
      height += count * heightItemComp + (count - 1) * heightSizedBox + 2 * heightSizedBox;
    }

    return AnimatedContainer(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      duration: const Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: ColoredBox(
          color: AppColors.black50,
          child: Padding(
            padding: const EdgeInsets.only(right: 1, top: 10, bottom: 10),
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              scrollbarOrientation: ScrollbarOrientation.right,
              child: ListView.separated(
                controller: _scrollController,
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
    final vm = context.read<MainGameViewModel>();
    final pc = vm.state.myPCs[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => vm.onOpenModalButtonPressed(index),
        child: SizedBox(
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
                  CircleIndexWidget(index: index),
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
                  const SizedBox(width: 4),
                  __ComputerItemButtonOrMiningWidget(index: index),
                ],
              ),
            ),
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
    context.select((MainGameViewModel vm) => vm.state.pcByIndex(index)?.miningToken);
    final pc = context.read<MainGameViewModel>().state.myPCs[index];

    final imagePath =
        pc.miningToken == null ? AppIconsImages.emptyIcon : AppImages.getTokenPathBySymbol(pc.miningToken!.symbol);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(imagePath == AppIconsImages.emptyIcon ? pi : 0),
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
    context.select((MainGameViewModel vm) => vm.state.pcByIndex(index)?.miningToken);
    final vm = context.read<MainGameViewModel>();
    final pc = vm.state.myPCs[index];

    return SizedBox(
      width: 120,
      child: TextButton(
        onPressed: () => vm.onOpenModalButtonPressed(index),
        child: Text(
          pc.miningToken != null ? 'Майнится: ${pc.miningToken?.symbol}' : 'НАЗНАЧИТЬ',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}