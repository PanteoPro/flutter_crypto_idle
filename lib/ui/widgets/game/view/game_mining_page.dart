import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_mining_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameMiningPage extends StatelessWidget {
  const GameMiningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderPage(
                    title: S.of(context).game_mining_title,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _MiningListWidget(),
                    ),
                  ),
                ],
              ),
              _ModulePcWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiningListWidget extends StatelessWidget {
  const _MiningListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((GameMiningViewModel vm) => vm.state.availableTokens.length);
    final tokens = context.read<GameMiningViewModel>().state.availableTokens;
    final items = List.generate(tokens.length, (index) => index);

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      children: items.map((index) => _MiningItemWidget(index: index)).toList(),
    );
  }
}

class _MiningItemWidget extends StatelessWidget {
  const _MiningItemWidget({
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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _MiningItemHeaderWidget(index: index),
            const SizedBox(height: 10),
            Expanded(child: _MiningItemInfoWidget(index: index)),
            const SizedBox(height: 10),
            _MiningItemButtonWidget(index: index),
          ],
        ),
      ),
    );
  }
}

class _MiningItemHeaderWidget extends StatelessWidget {
  const _MiningItemHeaderWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<GameMiningViewModel>().state.availableTokens[index];
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Image(
              image: AssetImage(AppImages.getTokenPathBySymbol(token.symbol)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(token.symbol, style: Theme.of(context).textTheme.headline5),
              Text(
                token.fullName,
                style: Theme.of(context).textTheme.headline6,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiningItemInfoWidget extends StatelessWidget {
  const _MiningItemInfoWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<GameMiningViewModel>().state.availableTokens[index];
    final priceToken = context.select((GameMiningViewModel vm) => vm.state.getCurrentPriceByToken(token));
    final data = context.read<GameMiningViewModel>().state.date;
    final priceTokenWeek =
        context.read<GameMiningViewModel>().state.getDataAfterPriceByToken(token: token, fromDate: data, daysAgo: 7);
    final priceTokenMonth =
        context.read<GameMiningViewModel>().state.getDataAfterPriceByToken(token: token, fromDate: data, daysAgo: 31);
    final priceTokenYear =
        context.read<GameMiningViewModel>().state.getDataAfterPriceByToken(token: token, fromDate: data, daysAgo: 365);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MiningItemInfoNowPriceWidget(price: priceToken.cost),
          _MiningItemInfoWeekPriceWidget(price: priceTokenWeek.cost),
          _MiningItemInfoMonthPriceWidget(price: priceTokenMonth.cost),
          _MiningItemInfoYearPriceWidget(price: priceTokenYear.cost),
        ],
      ),
    );
  }
}

class _MiningItemInfoNowPriceWidget extends StatelessWidget {
  const _MiningItemInfoNowPriceWidget({Key? key, required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_now_price_title}: ${S.of(context).text_with_dollar(price)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoWeekPriceWidget extends StatelessWidget {
  const _MiningItemInfoWeekPriceWidget({Key? key, required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_week_price_title}: ${S.of(context).text_with_dollar(price)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoMonthPriceWidget extends StatelessWidget {
  const _MiningItemInfoMonthPriceWidget({Key? key, required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_month_price_title}: ${S.of(context).text_with_dollar(price)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoYearPriceWidget extends StatelessWidget {
  const _MiningItemInfoYearPriceWidget({Key? key, required this.price}) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_year_price_title}: ${S.of(context).text_with_dollar(price)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemButtonWidget extends StatelessWidget {
  const _MiningItemButtonWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMiningViewModel>();

    return MyButton(
      color: Colors.green,
      onPressed: () => vm.onOpenButtonPressed(index),
      title: S.of(context).game_mining_set_pc_title,
    );
  }
}

class _ModulePcWidget extends StatelessWidget {
  const _ModulePcWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOpenModale = context.select((GameMiningViewModel vm) => vm.state.isOpenModale);
    if (!isOpenModale) return const SizedBox();

    final vm = context.read<GameMiningViewModel>();

    return Stack(
      children: [
        GestureDetector(
          onTap: () => vm.onExitModalAction(),
          child: Container(color: Colors.black.withAlpha(200)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                children: [
                  _ModulePcHeaderWidget(
                    onTap: vm.onExitModalAction,
                    symbol: vm.state.availableTokens[vm.state.modaleTokenIndex].symbol,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(S.of(context).game_mining_module_pc_title),
                  ),
                  const Expanded(child: _ModulePCListWidget()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ModulePcHeaderWidget extends StatelessWidget {
  const _ModulePcHeaderWidget({
    Key? key,
    required this.onTap,
    required this.symbol,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: HeaderPage(
        title: S.of(context).game_mining_module_title(symbol),
        onTap: onTap,
      ),
    );
  }
}

class _ModulePCListWidget extends StatelessWidget {
  const _ModulePCListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMiningViewModel>();
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return _ModulePCItemWidget(index: index);
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(height: 20);
      },
      itemCount: vm.state.filtered?.length ?? 0,
    );
  }
}

class _ModulePCItemWidget extends StatelessWidget {
  const _ModulePCItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Theme.of(context).canvasColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _ModulePCItemImageWidget(),
              const SizedBox(width: 10),
              Expanded(child: _ModulePCItemInfoWidget(index: index)),
              _ModulePCItemChangeWidget(indexPC: index),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModulePCItemImageWidget extends StatelessWidget {
  const _ModulePCItemImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Placeholder(),
    );
  }
}

class _ModulePCItemInfoWidget extends StatelessWidget {
  const _ModulePCItemInfoWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ModulePCItemInfoTitleWidget(index: index),
          _ModulePCItemInfoPowerWidget(index: index),
          _ModulePCItemInfoMiningWidget(index: index),
        ],
      ),
    );
  }
}

class _ModulePCItemInfoTitleWidget extends StatelessWidget {
  const _ModulePCItemInfoTitleWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final name = context.read<GameMiningViewModel>().state.filtered?[index].name;
    return Text(
      name ?? '',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class _ModulePCItemInfoPowerWidget extends StatelessWidget {
  const _ModulePCItemInfoPowerWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final power = context.read<GameMiningViewModel>().state.filtered?[index].power;
    return Text(
      '${S.of(context).game_mining_module_pc_power_title}: ${S.of(context).text_with_power_mining(power ?? "")}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _ModulePCItemInfoMiningWidget extends StatelessWidget {
  const _ModulePCItemInfoMiningWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameMiningViewModel vm) => vm.state.filtered?[index].miningToken);
    return Text(
      '${S.of(context).game_mining_module_pc_mining_title}: ${token?.symbol ?? S.of(context).game_mining_module_pc_mining_empty_title}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _ModulePCItemChangeWidget extends StatelessWidget {
  const _ModulePCItemChangeWidget({
    Key? key,
    required this.indexPC,
  }) : super(key: key);

  final int indexPC;

  @override
  Widget build(BuildContext context) {
    final miningToken = context.select((GameMiningViewModel vm) => vm.state.filtered?[indexPC].miningToken);
    final vm = context.read<GameMiningViewModel>();
    final token = vm.state.availableTokens[vm.state.modaleTokenIndex];
    final value = token.id == miningToken?.id;

    return Transform.scale(
      scale: 3,
      child: Checkbox(
        checkColor: Colors.white,
        value: value,
        onChanged: (value) => vm.onChangeMiningToken(indexPC),
      ),
    );
  }
}
