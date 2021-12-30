part of '../../main_game_page.dart';

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
                title: S.of(context).game_main_actions_buy_pc,
                onPressed: () => vm.onBuyPcButtonPressed(context),
              ),
              const SizedBox(width: 12),
              _ActionItemWidget(
                title: S.of(context).game_main_actions_buy_flat,
                onPressed: () => vm.onBuyFlatButtonPressed(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionItemWidget(
                title: S.of(context).game_main_actions_crypto_wallet,
                onPressed: () => vm.onWalletButtonPressed(context),
              ),
              const SizedBox(width: 12),
              _ActionItemWidget(
                title: S.of(context).game_main_actions_statistics,
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
    return GameButtonWidget.game(
      text: title,
      onPressed: onPressed,
      font: AppFonts.mainButton.copyWith(fontSize: 14),
    );
  }
}
