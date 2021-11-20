import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/material.dart';

class MainGamePage extends StatelessWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).main_game_appbar_title,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('13.05.2015', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: const <Widget>[
              _GameImageWidget(),
              _BalanceWidget(),
              _ActionsWidget(),
              _CurrentInfoWidget(),
              _MonthInfoWidget(),
              _StatisticWidget(),
            ],
          ),
        ),
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
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    S.of(context).main_game_cash_balance_title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    S.of(context).text_with_dollar(100.24),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    S.of(context).main_game_crypto_balance_title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    S.of(context).text_with_dollar(4234.23),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            width: 16,
            height: 16,
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
      children: [
        _InfoItemWidget(
          title: S.of(context).main_game_info_place_title,
          value: 'Твоя квартира',
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_info_count_pc_title,
          value: S.of(context).text_with_slash(6, 10),
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_info_energy_title,
          value: S.of(context).text_with_energy(523),
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_info_power_mining_title,
          value: S.of(context).text_with_power_mining(523),
        ),
      ],
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
      children: [
        _InfoItemWidget(
          title: S.of(context).main_game_month_flat_title,
          value: S.of(context).text_with_dollar(-44),
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_month_energy_title,
          value: S.of(context).text_with_dollar(-120),
        ),
      ],
    );
  }
}

class _StatisticWidget extends StatelessWidget {
  const _StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tempSymbols = ['BTC', 'ETC', 'ETH', 'BNB'];
    return _WrapperBlockWidget(
      title: S.of(context).main_game_stat_title,
      children: [
        _InfoItemWidget(
          title: S.of(context).main_game_stat_spend_all_title,
          value: S.of(context).text_with_dollar(432.23),
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_stat_spend_flat_title,
          value: S.of(context).text_with_dollar(432.23),
        ),
        _InfoItemWidget(
          title: S.of(context).main_game_stat_spend_energy_title,
          value: S.of(context).text_with_dollar(432.23),
        ),
        SizedBox(height: 20),
        for (String symbol in tempSymbols)
          _InfoItemWidget(
            title: S.of(context).main_game_stat_earn_on_crypto_title(symbol),
            value: S.of(context).text_with_dollar(432.23),
          ),
        SizedBox(height: 20),
        for (String symbol in tempSymbols)
          _InfoItemWidget(
            title: S.of(context).main_game_stat_mining_on_crypto_title(symbol),
            value: S.of(context).text_with_dollar(432.23),
          ),
      ],
    );
  }
}
