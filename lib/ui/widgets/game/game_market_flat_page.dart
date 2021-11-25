import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameMarketFlatPage extends StatelessWidget {
  const GameMarketFlatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              HeaderPage(
                title: S.of(context).game_market_flat_title,
              ),
              const Expanded(child: _MarketFlatListWidget()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketFlatListWidget extends StatelessWidget {
  const _MarketFlatListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatLenght = context.select((GameMarketFlatViewModel vm) => vm.state.flats.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: double.infinity,
        child: ListView.separated(
          itemCount: flatLenght,
          itemBuilder: (ctx, index) {
            return _MarketFlatItemWidget(index: index);
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 20);
          },
        ),
      ),
    );
  }
}

class _MarketFlatItemWidget extends StatelessWidget {
  const _MarketFlatItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: Theme.of(context).canvasColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _HeaderItemWidget(index: index),
            const SizedBox(height: 10),
            _BodyItemWidget(index: index),
            const SizedBox(height: 10),
            _ButtonsItemWidget(index: index),
          ],
        ),
      ),
    );
  }
}

class _HeaderItemWidget extends StatelessWidget {
  const _HeaderItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final isBuy = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index].isBuy);
    final title = context.read<GameMarketFlatViewModel>().state.flats[index].name;
    return Row(
      children: [
        Text(title),
        Expanded(
          child: Text(
            isBuy ? S.of(context).game_market_flat_own_item_title : '',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  const _BodyItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 80,
          width: 80,
          child: Placeholder(),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CostItemWidget(index: index),
              _MonthItemWidget(index: index),
              _CountPCItemWidget(index: index),
            ],
          ),
        ),
      ],
    );
  }
}

class _CostItemWidget extends StatelessWidget {
  const _CostItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final cost = context.read<GameMarketFlatViewModel>().state.flats[index].cost;
    return Text('${S.of(context).game_market_flat_cost_item_title}: ${S.of(context).text_with_dollar(cost)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _MonthItemWidget extends StatelessWidget {
  const _MonthItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final costMonth = context.read<GameMarketFlatViewModel>().state.flats[index].costMonth;
    return Text('${S.of(context).game_market_flat_month_item_title}: ${S.of(context).text_with_dollar(costMonth)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _CountPCItemWidget extends StatelessWidget {
  const _CountPCItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final countPC = context.read<GameMarketFlatViewModel>().state.flats[index].countPC;
    return Text('${S.of(context).game_market_flat_count_pc_item_title}: $countPC',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _ButtonsItemWidget extends StatelessWidget {
  const _ButtonsItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final isBuy = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index].isBuy);
    final isActive = context.select((GameMarketFlatViewModel vm) => vm.state.flats[index].isActive);
    final balance = context.select((GameMarketFlatViewModel vm) => vm.state.money);
    final flatCost = context.read<GameMarketFlatViewModel>().state.flats[index].cost;

    final showActivateButton = !isActive && isBuy;
    final showBuyButton = balance >= flatCost && !isBuy;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showActivateButton) _ActivateButtonWidget(index: index),
        if (showBuyButton) _BuyButtonWidget(index: index),
        if (isActive) const _IsActiveButtonWidget(),
      ],
    );
  }
}

class _BuyButtonWidget extends StatelessWidget {
  const _BuyButtonWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketFlatViewModel>();
    final gvm = context.read<GameViewModel>();
    return MyButton(
      onPressed: () => vm.onBuyButtonPressed(index, gvm),
      title: S.of(context).game_market_flat_buy_item_title,
      color: Colors.green,
    );
  }
}

class _ActivateButtonWidget extends StatelessWidget {
  const _ActivateButtonWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketFlatViewModel>();
    final gvm = context.read<GameViewModel>();
    return MyButton(
      onPressed: () => vm.onActivateButtonPressed(index, gvm),
      title: S.of(context).game_market_flat_change_item_title,
      color: Colors.yellow,
      textColor: Colors.black,
    );
  }
}

class _IsActiveButtonWidget extends StatelessWidget {
  const _IsActiveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: null,
      title: S.of(context).game_market_flat_status_active_title,
      color: Colors.red,
      textColor: Colors.white,
    );
  }
}
