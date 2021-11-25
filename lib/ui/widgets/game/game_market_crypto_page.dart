import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.day, this.cost);
  final String day;
  final double cost;
}

class GameMarketCryptoPage extends StatelessWidget {
  const GameMarketCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: [
              const _HeaderWidget(),
              _ChartWidget(),
              const _CostWidget(),
              const _CountCryptoWidget(),
              const SizedBox(height: 40),
              const _TradeWidget(),
            ],
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
    return SizedBox(
      height: 300,
      child: ColoredBox(
        color: Colors.white,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              // Bind data source
              dataSource: <ChartData>[
                // ChartData('22.05.21', 4324.23),
                // ChartData('23.05.21', 4329.23),
                // ChartData('24.05.21', 4334.23),
                // ChartData('25.05.21', 4342.23),
                // ChartData('26.05.21', 4304.23),
                // ChartData('27.05.21', 4304.23),
                ChartData('28.05.21', 4304.23),
                ChartData('29.05.21', 4304.23),
                ChartData('30.05.21', 4304.23),
                ChartData('31.05.21', 4304.23),
                ChartData('32.05.21', 4394.23),
                ChartData('01.06.21', 4394.23),
                ChartData('02.06.21', 5000.23),
              ],
              xValueMapper: (ChartData data, _) => data.day,
              yValueMapper: (ChartData data, _) => data.cost,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          _TradePriceSellWidget(),
          SizedBox(height: 10),
          _TradeCountSellWidget(),
          _TradeCountSellButtonsWidget(),
          SizedBox(height: 10),
          _TradeButtonsWidget(),
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
    final gvm = context.read<GameViewModel>();
    return Row(
      children: [
        Expanded(
          child: MyButton(
            color: Colors.red,
            onPressed: () => vm.onSellNowButtonPressed(gvm),
            title: S.of(context).game_crypto_market_fast_sell_title,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MyButton(
            color: Colors.red,
            onPressed: () => vm.onSellLimitButtonPressed(gvm),
            title: S.of(context).game_crypto_market_sell_title,
          ),
        ),
      ],
    );
  }
}

class _TradePriceSellWidget extends StatelessWidget {
  const _TradePriceSellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return TextField(
      controller: vm.priceTextController,
      decoration: InputDecoration(
        label: Text(S.of(context).game_crypto_market_price_input_title),
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

class _TradeCountSellWidget extends StatelessWidget {
  const _TradeCountSellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return TextField(
      controller: vm.volumeTextController,
      decoration: InputDecoration(
        label: Text(S.of(context).game_crypto_market_count_input_title),
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

class _TradeCountSellButtonsWidget extends StatelessWidget {
  const _TradeCountSellButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    return Row(
      children: [
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => vm.onChangeVolumeButtonPressed(PercentButton.p25),
            title: '25%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => vm.onChangeVolumeButtonPressed(PercentButton.p50),
            title: '50%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => vm.onChangeVolumeButtonPressed(PercentButton.p75),
            title: '75%',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TradeCountSellButtonsItemWidget(
            onPressed: () => vm.onChangeVolumeButtonPressed(PercentButton.p100),
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
