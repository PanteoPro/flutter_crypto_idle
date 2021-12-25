import 'package:crypto_idle/Widgets/old_buttons.dart';
import 'package:crypto_idle/Widgets/old_header_page.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameMarketPCPage extends StatelessWidget {
  const GameMarketPCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: PageWrapperWidget(
            child: Column(
              children: [
                HeaderPage(
                  title: S.of(context).game_market_pc_title,
                ),
                const Expanded(child: _MarketPCListWidget()),
              ],
            ),
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
    final pcs_length = context.select((GameMarketPCViewModel vm) => vm.state.marketPCs.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: double.infinity,
        child: ListView.separated(
          itemCount: pcs_length,
          itemBuilder: (ctx, index) {
            return _MarketPCItemWidget(index: index);
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
  const _MarketPCItemWidget({Key? key, required this.index}) : super(key: key);

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
  const _HeaderItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final pc = context.read<GameMarketPCViewModel>().state.marketPCs[index];
    return Row(
      children: [
        Text(pc.name),
        Expanded(
          child: _HeaderItemCountWidget(pcId: pc.id),
        ),
      ],
    );
  }
}

class _HeaderItemCountWidget extends StatelessWidget {
  const _HeaderItemCountWidget({
    Key? key,
    required this.pcId,
  }) : super(key: key);

  final int pcId;

  @override
  Widget build(BuildContext context) {
    final ownPCs = context.select((GameMarketPCViewModel vm) => vm.state.ownPCs);
    final count = context.read<GameMarketPCViewModel>().state.getCountPCsById(pcId);

    return Text(
      S.of(context).game_market_pc_you_have_item_title(count),
      textAlign: TextAlign.end,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  const _BodyItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameMarketPCViewModel>().state;
    final pc = state.marketPCs[index];
    final isHavePC = state.isHavePCById(pc.id);
    return Row(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Image.asset(AppImages.getPcPathByName(pc.name)),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CostItemWidget(cost: pc.cost),
              if (isHavePC) _CostSellItemWidget(costSell: pc.costSell),
              _PowerItemWidget(power: pc.power),
              _EnergyItemWidget(energy: pc.energy),
              Text(
                'Нужен уровен помещения - ${pc.needLevel}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CostItemWidget extends StatelessWidget {
  const _CostItemWidget({Key? key, required this.cost}) : super(key: key);

  final double cost;

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_cost_item_title}: ${S.of(context).text_with_dollar(cost)}',
        style: Theme.of(context).textTheme.bodyText2);
  }
}

class _CostSellItemWidget extends StatelessWidget {
  const _CostSellItemWidget({Key? key, required this.costSell}) : super(key: key);

  final double costSell;

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_cost_sell_item_title}: ${S.of(context).text_with_dollar(costSell)}',
        style: Theme.of(context).textTheme.bodyText2);
  }
}

class _PowerItemWidget extends StatelessWidget {
  const _PowerItemWidget({Key? key, required this.power}) : super(key: key);

  final double power;

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_power_item_title}: ${S.of(context).text_with_power_mining(power)}',
        style: Theme.of(context).textTheme.bodyText2);
  }
}

class _EnergyItemWidget extends StatelessWidget {
  const _EnergyItemWidget({Key? key, required this.energy}) : super(key: key);

  final double energy;

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).game_market_pc_energy_item_title}: ${S.of(context).text_with_energy(energy)}',
        style: Theme.of(context).textTheme.bodyText2);
  }
}

class _ButtonsItemWidget extends StatelessWidget {
  const _ButtonsItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final state = context.read<GameMarketPCViewModel>().state;
    final pc = state.marketPCs[index];
    final balance = context.select((GameMarketPCViewModel vm) => vm.state.money);
    final enoughtLevel = context.select((GameMarketPCViewModel vm) => vm.state.enoughtLevelByPC(pc));
    final haveSpaceForNewPC = context.select((GameMarketPCViewModel vm) => vm.state.haveSpaceForNewPC());

    final bool haveThat = state.isHavePCById(pc.id);
    final bool enoughMoney = balance >= pc.cost;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (haveThat == true) _SellButtonWidget(index: index),
        const SizedBox(width: 10),
        if (enoughMoney == true && enoughtLevel && haveSpaceForNewPC) _BuyButtonWidget(index: index),
        if (!enoughtLevel) const _NotEnoughtButtonWidget(),
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
    final vm = context.read<GameMarketPCViewModel>();
    return MyButton(
      onPressed: () => vm.onBuyButtonPressed(index),
      title: S.of(context).game_market_pc_buy_item_title,
      color: Colors.green,
    );
  }
}

class _NotEnoughtButtonWidget extends StatelessWidget {
  const _NotEnoughtButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {},
      title: 'Не хватате уровня помещения',
      color: Colors.grey,
    );
  }
}

class _SellButtonWidget extends StatelessWidget {
  const _SellButtonWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketPCViewModel>();
    return MyButton(
      onPressed: () => vm.onSellButtonPressed(index),
      title: S.of(context).game_market_pc_sell_item_title,
      color: Colors.red,
    );
  }
}
