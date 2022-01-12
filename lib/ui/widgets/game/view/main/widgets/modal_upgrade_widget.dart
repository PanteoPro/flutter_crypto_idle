part of '../main_game_page.dart';

class _ModalUpgradeWidget extends StatelessWidget {
  const _ModalUpgradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((ClickerGameViewModel vm) => vm.state.clicker.level);
    final clicker = context.read<ClickerGameViewModel>().state.clicker;
    final isModalUpgrade = context.select((ClickerGameViewModel vm) => vm.state.isModalUpgrade);
    if (!isModalUpgrade) return const SizedBox();
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: context.read<ClickerGameViewModel>().onCloseModal,
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ColoredBox(
              color: AppColors.black50,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.green),
              color: AppColors.secondGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _HeaderWidget(),
                  const SizedBox(height: 10),
                  const _UpgradeWidget(),
                  const SizedBox(height: 10),
                  const _ButtonUpgradeWidget(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '${S.of(context).game_main_modal_upgrade_cost}: ${S.of(context).text_with_dollar(clicker.upgradeCost.toStringAsFixed(2))}',
                        style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
                      ),
                      const Spacer(),
                      Text(
                        '${S.of(context).game_main_modal_upgrade_level}: ${clicker.level}',
                        style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
                      ),
                      const Spacer()
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ClickerGameViewModel>();
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 4,
          child: Text(
            S.of(context).game_main_modal_upgrade_title,
            textAlign: TextAlign.center,
            style: AppFonts.main.copyWith(color: AppColors.white),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: vm.onCloseModal,
                child: Image.asset(
                  AppIconsImages.exit,
                  width: 16,
                  height: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UpgradeWidget extends StatelessWidget {
  const _UpgradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((ClickerGameViewModel vm) => vm.state.clicker.level);

    final clicker = context.read<ClickerGameViewModel>().state.clicker;
    final nowMin = S.of(context).text_with_dollar(clicker.minMoney.toStringAsFixed(2));
    final nowMax = S.of(context).text_with_dollar(clicker.maxMoney.toStringAsFixed(2));
    final nowCrit = S.of(context).text_with_dollar(clicker.critMoney.toStringAsFixed(2));
    final nowProbability = '${(clicker.probabilityCrit * 100).toStringAsFixed(1)}%';

    final nextMin = S.of(context).text_with_dollar(AppConfig.minByLevel(clicker.level + 1).toStringAsFixed(2));
    final nextMax = S.of(context).text_with_dollar(AppConfig.maxByLevel(clicker.level + 1).toStringAsFixed(2));
    final nextCrit = S.of(context).text_with_dollar(AppConfig.critByLevel(clicker.level + 1).toStringAsFixed(2));
    final nextProbability = '${(AppConfig.probabilityByLevel(clicker.level + 1) * 100).toStringAsFixed(1)}%';
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Row(
            children: [
              Spacer(flex: 3),
              Expanded(
                child: Image.asset(AppIconsImages.upgradeArrow),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
        Column(
          children: [
            _UpgradeInfoItem(
              title: S.of(context).game_main_modal_upgrade_min,
              now: nowMin,
              next: nextMin,
            ),
            const SizedBox(height: 12),
            _UpgradeInfoItem(
              title: S.of(context).game_main_modal_upgrade_max,
              now: nowMax,
              next: nextMax,
            ),
            const SizedBox(height: 12),
            _UpgradeInfoItem(
              title: S.of(context).game_main_modal_upgrade_crit,
              now: nowCrit,
              next: nextCrit,
            ),
            const SizedBox(height: 12),
            _UpgradeInfoItem(
              title: S.of(context).game_main_modal_upgrade_probability_crit,
              now: nowProbability,
              next: nextProbability,
            ),
          ],
        ),
      ],
    );
  }
}

class _UpgradeInfoItem extends StatelessWidget {
  const _UpgradeInfoItem({
    Key? key,
    required this.title,
    required this.now,
    required this.next,
  }) : super(key: key);

  final String title;
  final String now;
  final String next;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: AppFonts.body.copyWith(color: AppColors.white),
          ),
        ),
        Expanded(
          child: Text(
            now,
            textAlign: TextAlign.right,
            style: AppFonts.body.copyWith(color: AppColors.grey),
          ),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            next,
            style: AppFonts.main.copyWith(color: AppColors.white),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _ButtonUpgradeWidget extends StatelessWidget {
  const _ButtonUpgradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ClickerGameViewModel>();
    final money = context.select((GameViewModel vm) => vm.state.money);

    final isCanUpdate = money >= vm.state.clicker.upgradeCost;
    return GameButtonWidget.game(
      onPressed: isCanUpdate ? vm.onClickUpgradeButton : null,
      text: S.of(context).game_main_modal_upgrade_button,
      font: AppFonts.main,
      backgroundColor: AppColors.secondGrey,
      borderColor: isCanUpdate ? AppColors.green : AppColors.lightGrey,
      textColor: isCanUpdate ? AppColors.green : AppColors.lightGrey,
    );
  }
}
