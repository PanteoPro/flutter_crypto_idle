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
          'LVL $level',
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
    final name = context.read<GameMarketFlatViewModel>().state.flats[index].name;
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
      'Максимум установок: $countPC',
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
            'Стоимость: $cost',
            textAlign: TextAlign.left,
            style: AppFonts.mainButton.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'Ежемесячная плата: $monthCost',
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
        ? 'АКТИВНО'
        : isBuy
            ? 'ПРИОБРЕТЕНО'
            : 'ПРИОБРЕСТИ';

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
