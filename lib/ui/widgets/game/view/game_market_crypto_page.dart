import 'dart:math';

import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ChartData {
  ChartData(this.day, this.cost);
  final DateTime day;
  final double cost;
}

class GameMarketCryptoPage extends StatelessWidget {
  const GameMarketCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GameAppBar(),
      body: SafeArea(
        child: PageWrapperWidget(
          child: ColoredBox(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              children: const [
                _HeaderWidget(),
                _ChartWidget(),
                _CostWidget(),
                _CountCryptoWidget(),
                SizedBox(height: 10),
                _TradeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final token = context.read<GameMarketCryptoViewModel>().state.token;
    return HeaderPage(
      title: '${S.of(context).text_with_slash(token?.symbol ?? 'NONE', 'USD')} ${token?.fullName}',
    );
  }
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prices = context.select((GameMarketCryptoViewModel vm) => vm.state.prices);
    final latestPrices = prices.reversed.take(200).toList().reversed.toList();
    final dataChart = latestPrices.map((PriceToken price) => ChartData(price.date, price.cost)).toList();
    final dateFormater = DateFormat.Md('ru-ru');

    var visibleMaximum = 0.0;
    var visibleMinimum = latestPrices.first.cost;
    for (var element in latestPrices) {
      if (visibleMaximum < element.cost) visibleMaximum = element.cost;
      if (visibleMinimum > element.cost) visibleMinimum = element.cost;
    }

    final difference = visibleMaximum - visibleMinimum;
    final expandValue = (difference * 0.3);

    var devidedValue = 100.0;
    if (visibleMaximum < 100 || visibleMinimum < 100) devidedValue = 10;
    if (visibleMaximum < 1 || visibleMinimum < 1) devidedValue = 0.01;

    final resMax = ((visibleMaximum + expandValue) / devidedValue).ceil() * devidedValue;
    final resMin = (max(visibleMinimum - expandValue, 0) / devidedValue).floor() * devidedValue;

    // print("$visibleMaximum, $resMax");
    // print("$visibleMinimum, $resMin");

    final isScam = latestPrices.where((element) => element.cost <= 0).isNotEmpty;
    // prices.forEach((elem) => print(elem.cost));

    return SizedBox(
      height: 250,
      child: SfChartTheme(
        data: SfChartThemeData(
          brightness: Brightness.dark,
          backgroundColor: Color.fromRGBO(32, 30, 59, 1),
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            anchorRangeToVisiblePoints: true,
            visibleMinimum: resMin.toDouble(),
            visibleMaximum: resMax.toDouble(),
          ),
          series: <FastLineSeries<ChartData, String>>[
            FastLineSeries<ChartData, String>(
              // Bind data source
              color: Colors.amber,
              dataSource: dataChart,
              xValueMapper: (ChartData data, _) => dateFormater.format(data.day),
              yValueMapper: (ChartData data, _) => data.cost,
              trendlines: !isScam
                  ? <Trendline>[
                      Trendline(
                        type: TrendlineType.exponential,
                        color: Colors.red,
                        width: 0.9,
                        opacity: 0.9,
                      ),
                    ]
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _CostWidget extends StatelessWidget {
  const _CostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = context.select((GameMarketCryptoViewModel vm) => vm.state.getLastPrice()).cost;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).primaryColor),
            bottom: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${S.of(context).game_crypto_market_cost_title}: ${S.of(context).text_with_dollar(price)}',
            ),
          ),
        ),
      ),
    );
  }
}

class _CountCryptoWidget extends StatelessWidget {
  const _CountCryptoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.select((GameMarketCryptoViewModel vm) => vm.state.token?.count);
    final symbol = context.read<GameMarketCryptoViewModel>().state.token?.symbol;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${S.of(context).game_crypto_market_balance_title}: ${count?.toStringAsFixed(8)} $symbol',
            ),
          ),
        ),
      ),
    );
  }
}

class _TradeWidget extends StatelessWidget {
  const _TradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const _TradeVolumeBuyWidget(),
          _TradeChangeVolumeButtonsWidget(clickHandler: vm.onChangeBuyVolumeButtonPressed),
          const SizedBox(height: 10),
          const _TradeVolumeSellWidget(),
          _TradeChangeVolumeButtonsWidget(clickHandler: vm.onChangeSellVolumeButtonPressed),
          const SizedBox(height: 10),
          const _TradeButtonsWidget(),
        ],
      ),
    );
  }
}

class _TradeButtonsWidget extends StatelessWidget {
  const _TradeButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return Row(
      children: [
        Expanded(
          child: MyButton(
            color: Colors.red,
            onPressed: () => vm.onSellNowButtonPressed(),
            title: S.of(context).game_crypto_market_fast_sell_title,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MyButton(
            color: Colors.green,
            onPressed: () => vm.onBuyNowButtonPressed(),
            title: S.of(context).game_crypto_market_fast_buy_title,
          ),
        ),
      ],
    );
  }
}

class _TradeVolumeBuyWidget extends StatelessWidget {
  const _TradeVolumeBuyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return TextField(
      controller: vm.volumeBuyTextController,
      decoration: InputDecoration(
        label: Text(S.of(context).game_crypto_market_count_buy_input_title),
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _TradeVolumeSellWidget extends StatelessWidget {
  const _TradeVolumeSellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return TextField(
      controller: vm.volumeSellTextController,
      decoration: InputDecoration(
        label: Text(S.of(context).game_crypto_market_count_sell_input_title),
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).canvasColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _TradeChangeVolumeButtonsWidget extends StatelessWidget {
  const _TradeChangeVolumeButtonsWidget({Key? key, required this.clickHandler}) : super(key: key);

  final Function(PercentButton) clickHandler;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return Row(
      children: [
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => clickHandler(PercentButton.p25),
            title: '25%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => clickHandler(PercentButton.p50),
            title: '50%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => clickHandler(PercentButton.p75),
            title: '75%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => clickHandler(PercentButton.p100),
            title: '100%',
          ),
        ),
      ],
    );
  }
}

class _TradeCountSellButtonsItemWidget extends StatelessWidget {
  const _TradeCountSellButtonsItemWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: onPressed,
      title: title,
      color: Theme.of(context).canvasColor,
      textColor: Colors.white,
    );
  }
}
