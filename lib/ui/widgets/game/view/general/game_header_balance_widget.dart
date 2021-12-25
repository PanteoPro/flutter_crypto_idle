import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/src/provider.dart';

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({
    Key? key,
    this.childrenInColumn,
  }) : super(key: key);

  final List<Widget>? childrenInColumn;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          const _BalanceWidget(),
          if (childrenInColumn != null) ...?childrenInColumn,
          // _NewsWidget(),
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _BalanceCashWidget(),
              SizedBox(height: 4),
              _BalanceCryptoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCashWidget extends StatelessWidget {
  const _BalanceCashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppIconsImages.cashIcon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        const _BalanceCashTextWidget(),
      ],
    );
  }
}

class _BalanceCashTextWidget extends StatelessWidget {
  const _BalanceCashTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final money = context.select((MainGameViewModel vm) => vm.state.money);
    return RichText(
      text: TextSpan(
        text: '${S.of(context).main_game_cash_balance_title}: ',
        style: AppFonts.main,
        children: [
          TextSpan(
            text: S.of(context).text_with_dollar(money),
            style: AppFonts.mainLight.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _BalanceCryptoWidget extends StatelessWidget {
  const _BalanceCryptoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppIconsImages.tokenIcon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        const _BalanceCryptoTextWidget(),
      ],
    );
  }
}

class _BalanceCryptoTextWidget extends StatelessWidget {
  const _BalanceCryptoTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cryptoBalance = context.select((MainGameViewModel vm) => vm.state.cryptoBalance);
    return RichText(
      text: TextSpan(
        text: '${S.of(context).main_game_crypto_balance_title}: ',
        style: AppFonts.main,
        children: [
          TextSpan(
            text: S.of(context).text_with_dollar(cryptoBalance),
            style: AppFonts.mainLight.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
