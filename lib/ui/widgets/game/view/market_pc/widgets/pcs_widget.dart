part of '../market_pc_page.dart';

class _PCsWidget extends StatelessWidget {
  const _PCsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countPCs = context.select((GameMarketPCViewModel vm) => vm.state.marketPCs.length);
    return ListView.separated(
      itemCount: countPCs,
      itemBuilder: (ctx, index) {
        return _PCItemWidget(index: index);
      },
      separatorBuilder: (ctx, index) => const SizedBox(height: 16),
    );
  }
}

class _PCItemWidget extends StatelessWidget {
  const _PCItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.secondGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            _MainContentWidget(index: index),
            _OtherContentWidget(index: index),
          ],
        ),
      ),
    );
  }
}

class _MainContentWidget extends StatelessWidget {
  const _MainContentWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InformationWidget(index: index),
        _ButtonsWidget(index: index),
      ],
    );
  }
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.read<GameMarketPCViewModel>().state.marketPCs[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pc.name,
          style: AppFonts.mainLight.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Image.asset(
              AppImages.getPcPathByName(pc.name),
              width: 48,
              height: 48,
            ),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Мощность: ${S.of(context).text_with_power_mining(pc.power)}',
                  style: AppFonts.mainButton.copyWith(color: AppColors.white),
                ),
                Text(
                  'Стоимость: ${S.of(context).text_with_dollar(pc.cost)}',
                  style: AppFonts.mainButton.copyWith(color: AppColors.white),
                ),
                _InformationSellCostWidget(index: index),
                Text(
                  'Потребление: ${S.of(context).text_with_energy(pc.energy)}',
                  style: AppFonts.mainButton.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _InformationSellCostWidget extends StatelessWidget {
  const _InformationSellCostWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.read<GameMarketPCViewModel>().state.marketPCs[index];
    final isHavePC = context.select((GameMarketPCViewModel vm) => vm.state.isHavePCById(pc.id));
    if (!isHavePC) return const SizedBox();
    return Text(
      'Стоимиость при продаже: ${S.of(context).text_with_dollar(pc.costSell)}',
      style: AppFonts.mainButton.copyWith(color: AppColors.white),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketPCViewModel>();
    final pc = vm.state.marketPCs[index];
    final balance = context.select((GameMarketPCViewModel vm) => vm.state.money);

    final enoughtLevel = context.select((GameMarketPCViewModel vm) => vm.state.enoughtLevelByPC(pc));
    final haveSpaceForNewPC = context.select((GameMarketPCViewModel vm) => vm.state.haveSpaceForNewPC());
    final bool haveThat = vm.state.isHavePCById(pc.id);
    final bool enoughMoney = balance >= pc.cost;

    final bool isBuyButton = enoughMoney && enoughtLevel;
    final bool isSellButton = haveThat && enoughtLevel;
    final bool isLevelButton = !enoughtLevel;

    return Column(
      children: [
        if (isBuyButton)
          GameButtonWidget.buy(
            text: 'Купить',
            onPressed: () => vm.onBuyButtonPressed(index),
            textColor: AppColors.white,
          ),
        if (isSellButton && isBuyButton) const SizedBox(height: 6),
        if (isSellButton)
          GameButtonWidget.buy(
            text: 'Продать',
            onPressed: () => vm.onSellButtonPressed(index),
            borderColor: AppColors.red,
            textColor: AppColors.white,
          ),
        if (isLevelButton)
          const GameButtonWidget.buy(
            text: 'Уровень',
            borderColor: AppColors.lightGrey,
            textColor: AppColors.lightGrey,
          ),
      ],
    );
  }
}

class _OtherContentWidget extends StatelessWidget {
  const _OtherContentWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.read<GameMarketPCViewModel>().state.marketPCs[index];
    final countHave = context.select((GameMarketPCViewModel vm) => vm.state.getCountPCsById(pc.id));
    return DecoratedBox(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: AppColors.mainGrey),
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Text(
              'У вас имеется: $countHave штук',
              style: AppFonts.mainButton.copyWith(
                color: AppColors.lightGrey,
              ),
            ),
            const Spacer(),
            Text(
              'Уровень: ${pc.needLevel}',
              style: AppFonts.mainButton.copyWith(
                color: AppColors.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
