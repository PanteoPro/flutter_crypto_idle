part of '../new_main_game_page.dart';

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
            Column(
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
            const _NewsOlderNewsWidget(),
          ],
        ),
      ),
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
    return AnimatedContainer(
      width: double.infinity,
      height: isShowNews ? 28 * 3 + 6 * 4 : 0,
      color: AppColors.black90,
      alignment: isShowNews ? Alignment.center : AlignmentDirectional.topCenter,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final news in newsToDisplay) ...[_NewsOlderItemWidget(news: news), const SizedBox(height: 6)],
          ],
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
    return SizedBox(
      height: 28,
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
                  ? const CircularProgressIndicator(color: AppColors.green, strokeWidth: 2)
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
      _isStartToClean = false;
      final color = isCritical ? AppColors.red : AppColors.dollar;
      final textStyle = isCritical ? AppFonts.critical : AppFonts.body;
      final speed = isCritical ? 1500 : 800;

      final digit = _DigitalWidget(money: rndMoney, color: color, textStyle: textStyle, speed: speed);

      setState(() {
        digitals.add(digit);
      });
    } else if (!_isStartToClean) {
      _isStartToClean = true;
      Future.delayed(const Duration(seconds: 2), () {
        digitals.clear();
      });
    } else {}
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
      height: 44,
      width: 140,
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
    final isLoadPcs = context.select((MainGameViewModel vm) => vm.state.isLoadPcs);
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: ColoredBox(
        color: AppColors.secondGrey,
        child: Padding(
          padding: const EdgeInsets.only(right: 1, top: 10, bottom: 10),
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            child: isLoadPcs
                ? const Center(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(color: AppColors.green, strokeWidth: 2),
                    ),
                  )
                : ListView.separated(
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
    );
  }
}

class _ComputerItemWidget extends StatelessWidget {
  const _ComputerItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.read<MainGameViewModel>().state.myPCs[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
      width: 100,
      child: TextButton(
        onPressed: () => vm.onOpenModalButtonPressed(index),
        child: Text(
          pc.miningToken != null ? 'Майнится: ${pc.miningToken?.symbol}' : 'НАЗНАЧИТЬ',
          textAlign: TextAlign.center,
          style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
