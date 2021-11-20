import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:flutter/material.dart';

class GameMarketPCPage extends StatelessWidget {
  const GameMarketPCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kGameAppBar(context),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              HeaderPage(
                title: S.of(context).game_market_pc_title,
                onTap: () {},
              ),
              const Expanded(child: _MarketPCListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketPCListWidget extends StatelessWidget {
  const _MarketPCListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: double.infinity,
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (ctx, index) {
            return _MarketPCItemWidget();
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(height: 20);
          },
        ),
      ),
    );
  }
}

class _MarketPCItemWidget extends StatelessWidget {
  const _MarketPCItemWidget({Key? key}) : super(key: key);

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
          children: const [
            _HeaderItemWidget(),
            SizedBox(height: 10),
            _BodyItemWidget(),
            SizedBox(height: 10),
            _ButtonsItemWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderItemWidget extends StatelessWidget {
  const _HeaderItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Старый ПК'),
        Expanded(
          child: Text(
            S.of(context).game_market_pc_you_have_item_title(5),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  const _BodyItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int balance = 70;
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
            children: const [
              _CostItemWidget(),
              if (balance >= 80) _CostSellItemWidget(),
              _PowerItemWidget(),
              _EnergyItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CostItemWidget extends StatelessWidget {
  const _CostItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_cost_item_title}: ${S.of(context).text_with_dollar(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _CostSellItemWidget extends StatelessWidget {
  const _CostSellItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_cost_sell_item_title}: ${S.of(context).text_with_dollar(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _PowerItemWidget extends StatelessWidget {
  const _PowerItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_power_item_title}: ${S.of(context).text_with_power_mining(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _EnergyItemWidget extends StatelessWidget {
  const _EnergyItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_energy_item_title}: ${S.of(context).text_with_energy(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _ButtonsItemWidget extends StatelessWidget {
  const _ButtonsItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool haveThat = true;
    const bool enoughMoney = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        if (haveThat == true) _SellButtonWidget(),
        SizedBox(width: 10),
        if (enoughMoney == true) _BuyButtonWidget(),
      ],
    );
  }
}

class _BuyButtonWidget extends StatelessWidget {
  const _BuyButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {},
      title: S.of(context).game_market_pc_buy_item_title,
      color: Colors.green,
    );
  }
}

class _SellButtonWidget extends StatelessWidget {
  const _SellButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {},
      title: S.of(context).game_market_pc_sell_item_title,
      color: Colors.red,
    );
  }
}
