import 'package:crypto_idle/Widgets/app_bar_info.dart';
import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/Widgets/header_page.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:flutter/material.dart';

class GameMiningPage extends StatelessWidget {
  const GameMiningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderPage(
                    title: S.of(context).game_mining_title,
                    onTap: () {},
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _MiningListWidget(),
                  )),
                ],
              ),
              // _ModulePcWidget(),
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
    final items = ['BTC', 'ETC', 'ETH', 'BNB', 'BTC', 'ETC', 'ETH'];
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      children: items.map((element) => _MiningItemWidget(element: element)).toList(),
    );
  }
}

class _MiningItemWidget extends StatelessWidget {
  const _MiningItemWidget({Key? key, required this.element}) : super(key: key);

  final String element;

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
          children: const [
            _MiningItemHeaderWidget(),
            SizedBox(height: 10),
            Expanded(child: _MiningItemInfoWidget()),
            SizedBox(height: 10),
            _MiningItemButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class _MiningItemHeaderWidget extends StatelessWidget {
  const _MiningItemHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 32, height: 32, child: Placeholder()),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BTC', style: Theme.of(context).textTheme.headline5),
            Text('Bitcoin', style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ],
    );
  }
}

class _MiningItemInfoWidget extends StatelessWidget {
  const _MiningItemInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MiningItemInfoNowPriceWidget(),
          _MiningItemInfoWeekPriceWidget(),
          _MiningItemInfoMonthPriceWidget(),
          _MiningItemInfoYearPriceWidget(),
        ],
      ),
    );
  }
}

class _MiningItemInfoNowPriceWidget extends StatelessWidget {
  const _MiningItemInfoNowPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_now_price_title}: ${S.of(context).text_with_dollar(4320.23)}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoWeekPriceWidget extends StatelessWidget {
  const _MiningItemInfoWeekPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_week_price_title}: ${S.of(context).text_with_dollar(4320.23)}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoMonthPriceWidget extends StatelessWidget {
  const _MiningItemInfoMonthPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_month_price_title}: ${S.of(context).text_with_dollar(4320.23)}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemInfoYearPriceWidget extends StatelessWidget {
  const _MiningItemInfoYearPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_year_price_title}: ${S.of(context).text_with_dollar(4320.23)}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _MiningItemButtonWidget extends StatelessWidget {
  const _MiningItemButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      color: Colors.green,
      onPressed: () {},
      title: S.of(context).game_mining_set_pc_title,
    );
  }
}

class _ModulePcWidget extends StatelessWidget {
  const _ModulePcWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            print('tap');
          },
          child: Container(color: Colors.black.withAlpha(200)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const _ModulePcHeaderWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(S.of(context).game_mining_module_pc_title),
                  ),
                  Expanded(child: _ModulePCListWidget()),
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
  const _ModulePcHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: HeaderPage(
        title: S.of(context).game_mining_module_title('BTC'),
        onTap: () {},
      ),
    );
  }
}

class _ModulePCListWidget extends StatelessWidget {
  const _ModulePCListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return _ModulePCItemWidget();
      },
      separatorBuilder: (ctx, index) {
        return SizedBox(height: 20);
      },
      itemCount: 15,
    );
  }
}

class _ModulePCItemWidget extends StatelessWidget {
  const _ModulePCItemWidget({Key? key}) : super(key: key);

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
              SizedBox(width: 10),
              Expanded(child: _ModulePCItemInfoWidget()),
              _ModulePCItemChangeWidget(),
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
  const _ModulePCItemInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ModulePCItemInfoTitleWidget(),
          _ModulePCItemInfoPowerWidget(),
          _ModulePCItemInfoMiningWidget(),
        ],
      ),
    );
  }
}

class _ModulePCItemInfoTitleWidget extends StatelessWidget {
  const _ModulePCItemInfoTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Простой ПК',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class _ModulePCItemInfoPowerWidget extends StatelessWidget {
  const _ModulePCItemInfoPowerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).game_mining_module_pc_power_title}: ${S.of(context).text_with_power_mining(156)}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _ModulePCItemInfoMiningWidget extends StatelessWidget {
  const _ModulePCItemInfoMiningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String symbol = 'BTC';
    return Text(
      '${S.of(context).game_mining_module_pc_mining_title}: ${symbol}',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _ModulePCItemChangeWidget extends StatelessWidget {
  const _ModulePCItemChangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 3,
      child: Checkbox(
        checkColor: Colors.white,
        value: false,
        onChanged: (value) {},
      ),
    );
  }
}
