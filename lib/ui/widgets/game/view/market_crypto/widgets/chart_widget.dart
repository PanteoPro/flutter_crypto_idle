part of '../market_crypto_page.dart';

class _ChartWidget extends StatefulWidget {
  const _ChartWidget({Key? key}) : super(key: key);

  @override
  State<_ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<_ChartWidget> {
  ChartSeriesController? _chartController;

  final chartData = <SalesData>[];

  /// Need change this logic to use controller
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    const maxValuesOnChars = 50;
    final prices = context.watch<GameMarketCryptoViewModel>().state.prices;
    chartData.clear();
    if (prices.length <= maxValuesOnChars) {
      chartData.addAll(prices.map((e) => SalesData(e.date, e.cost)));
    } else {
      chartData.addAll(
        prices.sublist(prices.length - maxValuesOnChars, prices.length).map(
              (e) => SalesData(e.date, e.cost),
            ),
      );
    }
    final lastPrice = prices.isNotEmpty ? prices.last : PriceToken.empty();
    chartData.addAll([
      SalesData(lastPrice.date.add(const Duration(days: 1)), null),
      SalesData(lastPrice.date.add(const Duration(days: 2)), null),
    ]);
    // if (prices.length >= maxValuesOnChars) {
    //   _chartController?.updateDataSource(
    //     addedDataIndex: chartData.length - 1,
    //     removedDataIndex: 0,
    //   );
    // }
  }

  // void addData() {
  //   final price = 100.12;
  //   chartData.add(SalesData(startDate.add(Duration(days: offsetData)), price));
  //   chartData.removeAt(0);
  //   offsetData++;
  //   _chartController.updateDataSource(
  //     addedDataIndex: chartData.length - 1,
  //     removedDataIndex: 0,
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ColoredBox(
        color: const Color(0xFF140F25),
        child: SfCartesianChart(
          trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
          ),
          plotAreaBorderWidth: 1,
          plotAreaBorderColor: Color(0xFF363C4E),
          primaryXAxis: DateTimeAxis(
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Color(0xFF363C4E),
            ),
            axisLine: AxisLine(color: Color(0xFF363C4E)),
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: const MajorGridLines(
              width: 1,
              color: Color(0xFF363C4E),
            ),
            axisLine: AxisLine(color: Color(0xFF363C4E)),
            opposedPosition: true,
            rangePadding: ChartRangePadding.round,
          ),
          series: <ChartSeries>[
            AreaSeries<SalesData, DateTime>(
              animationDelay: 0,
              onRendererCreated: (ChartSeriesController controller) {
                _chartController = controller;
              },
              dataSource: chartData,
              color: const Color(0x1A2196F3),
              borderColor: const Color(0xFF2196F3),
              borderWidth: 2,
              xValueMapper: (SalesData sales, _) => sales.data,
              yValueMapper: (SalesData sales, _) => sales.price,
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.data, this.price);

  final DateTime data;
  final double? price;
}
