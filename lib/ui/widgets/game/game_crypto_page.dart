import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/material.dart';

class GameCryptoPage extends StatelessWidget {
  const GameCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              HeaderPage(
                title: S.of(context).game_crypto_title,
                onTap: () {},
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
              Text(S.of(context).text_with_dollar(4320.34), style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      ),
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
            Icon(Icons.arrow_downward, size: 48, color: Theme.of(context).primaryColor),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemBuilder: (ctx, index) {
          return const _CryptoItemWidget();
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 10);
        },
        itemCount: 4,
      ),
    );
  }
}

class _CryptoItemWidget extends StatelessWidget {
  const _CryptoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.gameMarketCrypto);
      },
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
              const Expanded(child: __CryptoItemNameWidget()),
              const __CryptoItemCostWidget(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BTC', style: Theme.of(context).textTheme.headline5),
        Text('Bitcoin', style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}

class __CryptoItemCostWidget extends StatelessWidget {
  const __CryptoItemCostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("0.23451234", style: Theme.of(context).textTheme.headline5),
        Text(S.of(context).text_with_dollar(2345.23), style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}
