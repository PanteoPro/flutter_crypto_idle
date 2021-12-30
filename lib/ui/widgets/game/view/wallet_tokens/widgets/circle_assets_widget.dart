part of '../wallet_tokens_page.dart';

class _CircleAssetsWidget extends StatelessWidget {
  const _CircleAssetsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            S.of(context).game_wallet_assets_title,
            textAlign: TextAlign.left,
            style: AppFonts.main.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _CircleWidget(),
              Spacer(),
              _AssetsWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleWidget extends StatelessWidget {
  const _CircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokens = context.select((GameCryptoViewModel vm) => vm.state.getTokensWithPercent);

    return SizedBox(
      height: 100,
      width: 100,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        series: <CircularSeries>[
          DoughnutSeries<GameCryptoViewModelStateTokenWithPercent, String>(
            animationDuration: 0,
            innerRadius: '70%',
            radius: '100%',
            dataSource: tokens,
            pointColorMapper: (GameCryptoViewModelStateTokenWithPercent data, _) => data.color,
            xValueMapper: (GameCryptoViewModelStateTokenWithPercent data, _) => data.token.symbol,
            yValueMapper: (GameCryptoViewModelStateTokenWithPercent data, _) => data.percent,
          ),
        ],
      ),
    );
  }
}

class _AssetsWidget extends StatelessWidget {
  const _AssetsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokens = context.select((GameCryptoViewModel vm) => vm.state.getTokensWithPercent);
    final children =
        tokens.map((e) => _AssetItemWidget(color: e.color, symbol: e.token.symbol, percent: e.percent)).toList();
    final a = [...children];
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[children[i], SizedBox(height: i == children.length - 1 ? 0 : 6)]
        ],
      ),
    );
  }
}

class _AssetItemWidget extends StatelessWidget {
  const _AssetItemWidget({
    Key? key,
    required this.color,
    required this.symbol,
    required this.percent,
  }) : super(key: key);

  final Color color;
  final String symbol;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final percentText = (percent * 100).toStringAsFixed(2);
    return Row(
      children: [
        ColoredBox(
          color: color,
          child: const SizedBox(
            height: 7,
            width: 7,
          ),
        ),
        const SizedBox(width: 5),
        Text(symbol, style: AppFonts.body.copyWith(color: AppColors.lightGrey)),
        const Spacer(),
        Text('$percentText%', style: AppFonts.body.copyWith(color: AppColors.white)),
      ],
    );
  }
}
