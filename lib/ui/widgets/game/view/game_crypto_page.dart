import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCryptoPage extends StatelessWidget {
  const GameCryptoPage({Key? key}) : super(key: key);

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
                title: S.of(context).game_crypto_title,
              ),
              const _BalanceWidget(),
              const SizedBox(height: 20),
              const _HelperWidget(),
              const SizedBox(height: 10),
              const Expanded(child: _CryptoListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: Theme.of(context).primaryColor),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).game_crypto_cost_header_title, style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 10),
              const _BalanceValueWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceValueWidget extends StatelessWidget {
  const _BalanceValueWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final balance = context.watch<GameCryptoViewModel>().state.getBalance();
    return Text(
      S.of(context).text_with_dollar(balance.toStringAsFixed(2)),
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}

class _HelperWidget extends StatelessWidget {
  const _HelperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(S.of(context).game_crypto_helper_title, textAlign: TextAlign.center),
            Icon(Icons.arrow_downward, size: 32, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}

class _CryptoListWidget extends StatelessWidget {
  const _CryptoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokensLenght = context.select((GameCryptoViewModel vm) => vm.state.filtered.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemBuilder: (ctx, index) {
          return _CryptoItemWidget(index: index);
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 10);
        },
        itemCount: tokensLenght,
      ),
    );
  }
}

class _CryptoItemWidget extends StatelessWidget {
  const _CryptoItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameCryptoViewModel vm) => vm.state.filtered[index]);
    final vm = context.read<GameCryptoViewModel>();

    return GestureDetector(
      onTap: () => vm.onTokenPressed(context, token),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).canvasColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Placeholder(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: __CryptoItemNameWidget(index: index)),
              __CryptoItemCostWidget(index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class __CryptoItemNameWidget extends StatelessWidget {
  const __CryptoItemNameWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameCryptoViewModel vm) => vm.state.filtered[index]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(token.symbol, style: Theme.of(context).textTheme.headline5),
        Text(token.fullName, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

class __CryptoItemCostWidget extends StatelessWidget {
  const __CryptoItemCostWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((GameCryptoViewModel vm) => vm.state.filtered[index].count);
    context.select((GameCryptoViewModel vm) => vm.state.currentPrices);

    final vm = context.read<GameCryptoViewModel>();
    final token = vm.state.filtered[index];
    final countToken = token.count;
    final costInDollars = vm.state.getPriceByToken(token) * countToken;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(countToken.toStringAsFixed(8), style: Theme.of(context).textTheme.headline5),
        Text(S.of(context).text_with_dollar(costInDollars.toStringAsFixed(2)),
            style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}
