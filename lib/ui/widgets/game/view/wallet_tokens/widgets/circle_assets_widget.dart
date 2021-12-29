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
            'Распределение активов',
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
    return SizedBox(
      height: 100,
      width: 100,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        series: <CircularSeries>[
          DoughnutSeries<GDPData, String>(
            animationDuration: 0,
            innerRadius: '70%',
            radius: '100%',
            dataSource: getChartData(),
            pointColorMapper: (GDPData data, _) => data.color,
            xValueMapper: (GDPData data, _) => data.symbol,
            yValueMapper: (GDPData data, _) => data.percent,
          ),
        ],
      ),
      // child: CircularAssetsWidget(
      //   percents: [
      //     0.5,
      //     0.5,
      //   ],
      //   colors: [
      //     Colors.green,
      //     Colors.blue,
      //   ],
      //   lineColor: Colors.red,
      //   maxLineColor: Colors.green,
      //   text: 'hello',
      // ),
    );
  }

  List<GDPData> getChartData() {
    final chartData = <GDPData>[
      GDPData(symbol: 'AWE', percent: 0.32, color: Colors.green),
      GDPData(symbol: 'CAT', percent: 0.18, color: Colors.blue),
      GDPData(symbol: 'ZZL', percent: 0.10, color: Colors.red),
      GDPData(symbol: 'DOG', percent: 0.10, color: Colors.orange),
      GDPData(symbol: 'Other', percent: 0.3, color: Colors.grey),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData({
    required this.symbol,
    required this.percent,
    required this.color,
  });
  final String symbol;
  final double percent;
  final Color color;
}

class _AssetsWidget extends StatelessWidget {
  const _AssetsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: const [
          _AssetItemWidget(
            color: Colors.blue,
            symbol: 'TOK',
            percent: 0.52234124,
          ),
          SizedBox(height: 6),
          _AssetItemWidget(
            color: Colors.blue,
            symbol: 'TOK',
            percent: 0.52234124,
          ),
          SizedBox(height: 6),
          _AssetItemWidget(
            color: Colors.blue,
            symbol: 'TOK',
            percent: 0.52234124,
          ),
          SizedBox(height: 6),
          _AssetItemWidget(
            color: Colors.blue,
            symbol: 'TOK',
            percent: 0.52234124,
          ),
          SizedBox(height: 6),
          _AssetItemWidget(
            color: Colors.grey,
            symbol: 'TOK',
            percent: 0.02234124,
          ),
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
