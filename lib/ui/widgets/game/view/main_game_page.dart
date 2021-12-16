import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/game_over_modal.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/day_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainGamePage extends StatelessWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameOver = context.select((GameViewModel vm) => vm.state.gameOver);
    final vm = context.read<MainGameViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).main_game_appbar_title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: const [
          _AppBarDateWidget(),
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: vm.onReturnToMenuButtonPressed,
            icon: Icon(Icons.exit_to_app_sharp, color: gameOver ? Colors.yellow : Colors.white)),
      ),
      body: SafeArea(
        child: PageWrapperWidget(
          child: Stack(
            children: [
              ColoredBox(
                color: Theme.of(context).backgroundColor,
                child: Stack(
                  children: const [
                    _MainWidget(),
                    _PrototypeOfNewsWidget(),
                    ______BUTTONMONEY______(),
                  ],
                ),
              ),
              const GameOverModalWidget(),
              const _ExitModalWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExitModalWidget extends StatelessWidget {
  const _ExitModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isModalShow = context.select((MainGameViewModel vm) => vm.state.isModalShow);
    if (!isModalShow) return const SizedBox();
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _ExitModalTitleWidget(),
                  _ExitModalButtonsWidget(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExitModalTitleWidget extends StatelessWidget {
  const _ExitModalTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderPage(
      title: 'Вы точно хотите выйти в меню?',
      showBackIcon: false,
    );
  }
}

class _ExitModalButtonsWidget extends StatelessWidget {
  const _ExitModalButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    return Row(
      children: [
        Expanded(
          child: MyButton(
              color: Theme.of(context).splashColor,
              onPressed: () => vm.onYesExitButtonPressed(context),
              title: 'Выйти в меню'),
        ),
        const SizedBox(width: 30),
        Expanded(
            child: MyButton(
                color: Theme.of(context).splashColor, onPressed: vm.onNoExitButtonPressed, title: 'Остаться в игре')),
      ],
    );
  }
}

class ______BUTTONMONEY______ extends StatelessWidget {
  const ______BUTTONMONEY______({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ElevatedButton(
            onPressed: context.read<MainGameViewModel>().BABLO,
            child: Text('БАБЛО'),
          ),
        ),
      ),
    );
  }
}

class _PrototypeOfNewsWidget extends StatelessWidget {
  const _PrototypeOfNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        width: double.infinity,
        height: 100,
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('Новости'),
            ),
            Expanded(child: _PrototypeOfNewsItemsWidget()),
          ],
        ),
      ),
    );
  }
}

class _PrototypeOfNewsItemsWidget extends StatelessWidget {
  const _PrototypeOfNewsItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((DayStreamViewModel vm) => vm.newsListToDisplay.length);
    var news = context.read<DayStreamViewModel>().newsListToDisplay;
    // if (news.length > 3) {
    //   news = news.reversed.toList().getRange(0, 3).toList();
    // }
    var index = 1;
    final format = DateFormat.yMd('ru-ru');
    final newsWidgets = news.map((News news) {
      final font = Theme.of(context).textTheme.subtitle2;
      final double sizeIcon = font?.fontSize != null ? font!.fontSize! - 6 : 4;
      final widget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: sizeIcon,
            height: sizeIcon,
            margin: EdgeInsets.only(top: sizeIcon / 2),
            decoration: BoxDecoration(
              color: index == 1 ? Colors.green : Colors.yellow,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: news.text,
                style: font,
                children: [
                  TextSpan(
                    text: format.format(news.date),
                    style: TextStyle(
                      fontSize: font!.fontSize! / 2 + 4,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
      index += 1;
      return widget;
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: newsWidgets,
      ),
    );
  }
}

class _MainWidget extends StatelessWidget {
  const _MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        _GameImageWidget(),
        _BalanceWidget(),
        _ActionsWidget(),
        _CurrentInfoWidget(),
        _MonthInfoWidget(),
        _StatisticWidget(),
      ],
    );
  }
}

class _AppBarDateWidget extends StatelessWidget {
  const _AppBarDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final date = context.select((MainGameViewModel vm) => vm.state.date);
    final stringDate = format.format(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(stringDate, style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}

class _GameImageWidget extends StatelessWidget {
  const _GameImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Placeholder(),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: const <Widget>[
            Expanded(child: _BalanceDollarsWidget()),
            Expanded(child: _BalanceCryptoWidget()),
          ],
        ),
      ),
    );
  }
}

class _BalanceCryptoWidget extends StatelessWidget {
  const _BalanceCryptoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final money = context.select((MainGameViewModel vm) => vm.state.cryptoBalance);
    return Column(
      children: <Widget>[
        Text(
          S.of(context).main_game_crypto_balance_title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          S.of(context).text_with_dollar(money),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class _BalanceDollarsWidget extends StatelessWidget {
  const _BalanceDollarsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final money = context.select((MainGameViewModel vm) => vm.state.money);
    final monthConsume = context.select((MainGameViewModel vm) => vm.state.monthConsume);
    return Column(
      children: <Widget>[
        Text(
          S.of(context).main_game_cash_balance_title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        RichText(
          text: TextSpan(
            text: S.of(context).text_with_dollar(money),
            style: Theme.of(context).textTheme.bodyText2,
            children: monthConsume > money
                ? [
                    TextSpan(
                      text: '(-$monthConsume\$)',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.red, fontSize: 12),
                    ),
                  ]
                : [],
          ),
        ),
      ],
    );
  }
}

class _WrapperBlockWidget extends StatelessWidget {
  const _WrapperBlockWidget({Key? key, required this.children, this.title}) : super(key: key);

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Center(child: Text(title!, style: Theme.of(context).textTheme.headline2)),
              const SizedBox(height: 10)
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).canvasColor,
      child: _WrapperBlockWidget(
        children: [
          __ActionItemWidget(
            title: S.of(context).main_game_action_buy_pc_title,
            onTap: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.gameMarketPC);
            },
          ),
          const SizedBox(height: 10),
          __ActionItemWidget(
            title: S.of(context).main_game_action_buy_flat_title,
            onTap: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.gameMarketFlat);
            },
          ),
          const SizedBox(height: 10),
          __ActionItemWidget(
            title: S.of(context).main_game_action_mining_title,
            onTap: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.gameMining);
            },
          ),
          const SizedBox(height: 10),
          __ActionItemWidget(
            title: S.of(context).main_game_action_crypto_title,
            onTap: () {
              Navigator.of(context).pushNamed(MainNavigationRouteNames.gameCrypto);
            },
          ),
        ],
      ),
    );
  }
}

class __ActionItemWidget extends StatelessWidget {
  const __ActionItemWidget({Key? key, required this.title, required this.onTap}) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Color.fromRGBO(250, 255, 105, 1),
              ),
              color: Color.fromRGBO(215, 219, 90, 1),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Color.fromRGBO(160, 219, 77, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}

class _CurrentInfoWidget extends StatelessWidget {
  const _CurrentInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _WrapperBlockWidget(
      title: S.of(context).main_game_info_title,
      children: const [
        _CurrentInfoNameWidget(),
        _CurrentInfoCountPcWidget(),
        _CurrentInfoEnergyConsumeWidget(),
        _CurrentInfoPowerWidget(),
      ],
    );
  }
}

class _CurrentInfoPowerWidget extends StatelessWidget {
  const _CurrentInfoPowerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.powerPCs);
    return _InfoItemWidget(
      title: S.of(context).main_game_info_power_mining_title,
      value: S.of(context).text_with_power_mining(value),
    );
  }
}

class _CurrentInfoEnergyConsumeWidget extends StatelessWidget {
  const _CurrentInfoEnergyConsumeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.energyConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_info_energy_title,
      value: S.of(context).text_with_energy(value),
    );
  }
}

class _CurrentInfoCountPcWidget extends StatelessWidget {
  const _CurrentInfoCountPcWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = context.select((MainGameViewModel vm) => vm.state.myPCs.length);
    final maxPC = context.select((MainGameViewModel vm) => vm.state.flat.countPC);
    return _InfoItemWidget(
      title: S.of(context).main_game_info_count_pc_title,
      value: S.of(context).text_with_slash(current, maxPC),
    );
  }
}

class _CurrentInfoNameWidget extends StatelessWidget {
  const _CurrentInfoNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = context.select((MainGameViewModel vm) => vm.state.flat.name);
    return _InfoItemWidget(
      title: S.of(context).main_game_info_place_title,
      value: name,
    );
  }
}

class _InfoItemWidget extends StatelessWidget {
  const _InfoItemWidget({Key? key, required this.title, required this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          TextSpan(text: value, style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }
}

class _MonthInfoWidget extends StatelessWidget {
  const _MonthInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _WrapperBlockWidget(
      title: S.of(context).main_game_month_title,
      children: const [
        _MonthInfoFlatWidget(),
        _MonthInfoEnergyWidget(),
      ],
    );
  }
}

class _MonthInfoEnergyWidget extends StatelessWidget {
  const _MonthInfoEnergyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consume = context.select((MainGameViewModel vm) => vm.state.energyConsumeCost);
    return _InfoItemWidget(
      title: S.of(context).main_game_month_energy_title,
      value: S.of(context).text_with_dollar(-consume),
    );
  }
}

class _MonthInfoFlatWidget extends StatelessWidget {
  const _MonthInfoFlatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consume = context.select((MainGameViewModel vm) => vm.state.flatConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_month_flat_title,
      value: S.of(context).text_with_dollar(-consume),
    );
  }
}

class _StatisticWidget extends StatelessWidget {
  const _StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _WrapperBlockWidget(
      title: S.of(context).main_game_stat_title,
      children: const [
        _StatisticsSpendAllTimeWidget(),
        _StatisticsSpendAllTimeFlatWidget(),
        _StatisticsSpendAllTimePCWidget(),
        _StatisticsSpendAllTimeEnergyWidget(),
        SizedBox(height: 20),
        _StatisticsEarnTokensList(),
        SizedBox(height: 20),
        _StatisticsMiningTokensList(),
      ],
    );
  }
}

class _StatisticsMiningTokensList extends StatelessWidget {
  const _StatisticsMiningTokensList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.tokens.length);
    final tokens = context.read<MainGameViewModel>().state.tokens;
    final widgets = <Widget>[];
    for (var token in tokens) {
      widgets.add(_StatisticsMiningTokensItemWidget(token: token));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

class _StatisticsMiningTokensItemWidget extends StatelessWidget {
  const _StatisticsMiningTokensItemWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final earn = context.select((MainGameViewModel vm) => vm.state.miningTokensByTokenId(token.id));
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_mining_on_crypto_title(token.symbol),
      value: earn.toStringAsFixed(8),
    );
  }
}

class _StatisticsEarnTokensList extends StatelessWidget {
  const _StatisticsEarnTokensList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.tokens.length);
    final tokens = context.read<MainGameViewModel>().state.tokens;
    final widgets = <Widget>[];
    for (var token in tokens) {
      widgets.add(_StatisticsEarnTokensItemWidget(token: token));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

class _StatisticsEarnTokensItemWidget extends StatelessWidget {
  const _StatisticsEarnTokensItemWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final earn = context.select((MainGameViewModel vm) => vm.state.earnTokensByTokenId(token.id));
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_earn_on_crypto_title(token.symbol),
      value: S.of(context).text_with_dollar(earn),
    );
  }
}

class _StatisticsSpendAllTimeEnergyWidget extends StatelessWidget {
  const _StatisticsSpendAllTimeEnergyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.sumEnergyConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_spend_energy_title,
      value: S.of(context).text_with_dollar(value),
    );
  }
}

class _StatisticsSpendAllTimePCWidget extends StatelessWidget {
  const _StatisticsSpendAllTimePCWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.sumPCConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_spend_pc_title,
      value: S.of(context).text_with_dollar(value),
    );
  }
}

class _StatisticsSpendAllTimeFlatWidget extends StatelessWidget {
  const _StatisticsSpendAllTimeFlatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.sumFlatConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_spend_flat_title,
      value: S.of(context).text_with_dollar(value),
    );
  }
}

class _StatisticsSpendAllTimeWidget extends StatelessWidget {
  const _StatisticsSpendAllTimeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select((MainGameViewModel vm) => vm.state.sumConsume);
    return _InfoItemWidget(
      title: S.of(context).main_game_stat_spend_all_title,
      value: S.of(context).text_with_dollar(value),
    );
  }
}
