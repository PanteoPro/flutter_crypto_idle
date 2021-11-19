import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:flutter/material.dart';

class GameMarketFlatPage extends StatelessWidget {
  const GameMarketFlatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kGameAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            HeaderPage(
              title: S.of(context).game_market_flat_title,
              onTap: () {},
            ),
            const Expanded(child: _MarketFlatListWidget()),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: double.infinity,
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (ctx, index) {
            return const _MarketFlatItemWidget();
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
  const _MarketFlatItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
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
        Text('Твоя квартира'),
        Expanded(
          child: Text(
            S.of(context).game_market_flat_own_item_title,
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
              _MonthItemWidget(),
              _CountPCItemWidget(),
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
    return Text('${S.of(context).game_market_flat_cost_item_title}: ${S.of(context).text_with_dollar(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _MonthItemWidget extends StatelessWidget {
  const _MonthItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_flat_month_item_title}: ${S.of(context).text_with_dollar(50)}',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _CountPCItemWidget extends StatelessWidget {
  const _CountPCItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countPc = 5;
    return Text('${S.of(context).game_market_flat_count_pc_item_title}: $countPc',
        style: Theme.of(context).textTheme.headline6);
  }
}

class _ButtonsItemWidget extends StatelessWidget {
  const _ButtonsItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool ownThis = true;
    const bool enoughMoney = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        if (ownThis == true) _ChangeButtonWidget(),
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
      title: S.of(context).game_market_flat_buy_item_title,
      color: Colors.green,
    );
  }
}

class _ChangeButtonWidget extends StatelessWidget {
  const _ChangeButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {},
      title: S.of(context).game_market_flat_change_item_title,
      color: Colors.yellow,
      textColor: Colors.black,
    );
  }
}
