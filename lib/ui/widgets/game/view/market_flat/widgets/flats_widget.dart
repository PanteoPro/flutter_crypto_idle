part of '../market_flat_page.dart';

class _FlatsWidget extends StatelessWidget {
  const _FlatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countFlats = context.select((GameMarketFlatViewModel vm) => vm.state.flats.length);
    return ListView.separated(
      itemCount: countFlats,
      itemBuilder: (ctx, index) {
        return _FlatItemWidget(index: index);
      },
      separatorBuilder: (ctx, index) => const SizedBox(height: 16),
    );
  }
}

class _FlatItemWidget extends StatelessWidget {
  const _FlatItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _FlatItemMainWidget(index: index),
        _FlatItemLockWidget(index: index),
      ],
    );
  }
}

class _FlatItemLockWidget extends StatelessWidget {
  const _FlatItemLockWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final flat = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index]);
    final money = context.select((GameMarketFlatViewModel vm) => vm.state.money);
    final isShow = flat.isActive != true && flat.isBuy != true && flat.cost > money;
    if (!isShow) return const SizedBox();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: ColoredBox(
        color: AppColors.black80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppIconsImages.lock, width: 40, height: 40),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).game_market_flat_lock_title,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        style: AppFonts.main.copyWith(color: AppColors.white),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(
                          '${S.of(context).game_market_flat_info_cost}: ${S.of(context).text_with_dollar(flat.cost)}',
                          textAlign: TextAlign.right,
                          style: AppFonts.mainButton.copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlatItemMainWidget extends StatelessWidget {
  const _FlatItemMainWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final flatName = context.read<GameMarketFlatViewModel>().state.flats[index].name;
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.getFlatPathByName(flatName),
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _LevelWidget(index: index),
                Expanded(child: _DescriptionWidget(index: index)),
                _ButtonWidget(index: index),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LevelWidget extends StatelessWidget {
  const _LevelWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final level = context.read<GameMarketFlatViewModel>().state.flats[index].level;
    return SizedBox(
      width: 23,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          '${S.of(context).game_market_flat_info_level} $level',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleFlatWidget(index: index),
          _MaxPcFlatWidget(index: index),
          _CostsFlatWidget(index: index),
        ],
      ),
    );
  }
}

class _TitleFlatWidget extends StatelessWidget {
  const _TitleFlatWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final flat = context.read<GameMarketFlatViewModel>().state.flats[index];
    final name = locale.languageCode == 'ru' ? flat.name : flat.nameENG;
    return Text(
      name,
      style: AppFonts.mainLight.copyWith(color: AppColors.white),
    );
  }
}

class _MaxPcFlatWidget extends StatelessWidget {
  const _MaxPcFlatWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final countPC = context.read<GameMarketFlatViewModel>().state.flats[index].countPC;
    return Text(
      '${S.of(context).game_market_flat_info_count_pc}: $countPC',
      style: AppFonts.mainButton.copyWith(color: AppColors.white),
    );
  }
}

class _CostsFlatWidget extends StatelessWidget {
  const _CostsFlatWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final cost = context.read<GameMarketFlatViewModel>().state.flats[index].cost;
    final monthCost = context.read<GameMarketFlatViewModel>().state.flats[index].costMonth;
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            '${S.of(context).game_market_flat_info_cost}: ${S.of(context).text_with_dollar(cost)}',
            textAlign: TextAlign.left,
            style: AppFonts.mainButton.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '${S.of(context).game_market_flat_info_month_cost}: ${S.of(context).text_with_dollar(monthCost)}',
          style: AppFonts.mainButton.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketFlatViewModel>();
    final costFlat = vm.state.flats[index].cost;
    final isActive = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index].isActive);
    final isBuy = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index].isBuy);
    final money = context.select((GameMarketFlatViewModel vm) => vm.state.money);

    final text = isActive
        ? S.of(context).game_market_flat_status_active_title
        : isBuy
            ? S.of(context).game_market_flat_button_have
            : S.of(context).game_market_flat_button_buy;

    final color = isActive
        ? AppColors.lightGrey
        : isBuy
            ? AppColors.dollar
            : costFlat <= money
                ? AppColors.green
                : AppColors.red;
    final VoidCallback? action = isActive
        ? null
        : isBuy
            ? () => vm.onActivateButtonPressed(index)
            : () => vm.onBuyButtonPressed(index);
    return GameButtonWidget.buy(
      text: text,
      onPressed: action,
      borderColor: color,
      textColor: color,
    );
  }
}
