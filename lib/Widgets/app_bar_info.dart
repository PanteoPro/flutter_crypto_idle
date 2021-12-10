import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: Theme.of(context).textTheme.bodyText1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _BalanceWidget(),
          _CountPcWidget(),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              _DayWidget(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DayWidget extends StatelessWidget {
  const _DayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final date = context.select((GameViewModel vm) => vm.state.date);
    final stringDate = format.format(date);

    return Text(stringDate, style: Theme.of(context).textTheme.bodyText1);
  }
}

class _CountPcWidget extends StatelessWidget {
  const _CountPcWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxCountPC = context.select((GameViewModel vm) => vm.state.maxCountPC);
    final currentCountPC = context.select((GameViewModel vm) => vm.state.currentCountPC);
    return Text(
        '${S.of(context).game_app_bar_info_count_pc_title}: ${S.of(context).text_with_slash(currentCountPC, maxCountPC)}');
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final money = context.select((GameViewModel vm) => vm.state.money);
    return Text('${S.of(context).game_app_bar_info_balance_title}: ${S.of(context).text_with_dollar(money)}');
  }
}
