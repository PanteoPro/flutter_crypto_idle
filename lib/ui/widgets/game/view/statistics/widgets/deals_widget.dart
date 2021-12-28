part of '../game_statistics_page.dart';

class _DealsWidget extends StatelessWidget {
  const _DealsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealsBuyVolume = context.read<GameStatisticsViewModel>().state.statistics.dealsBuyVolume;
    final dealsSellVolume = context.read<GameStatisticsViewModel>().state.statistics.dealsSellVolume;
    return Column(
      children: [
        _ItemWidget(title: 'Совершено сделок на продажу', value: '${dealsSellVolume.length}'),
        SizedBox(height: 4),
        _ItemWidget(title: 'Совершено сделок на покупку', value: '${dealsBuyVolume.length}'),
        SizedBox(height: 4),
        _ItemWidget(
            title: 'Объем продаж', value: S.of(context).text_with_dollar(dealsSellVolume.sum.toStringAsFixed(2))),
        SizedBox(height: 4),
        _ItemWidget(
            title: 'Объем покупок', value: S.of(context).text_with_dollar(dealsBuyVolume.sum.toStringAsFixed(2))),
      ],
    );
  }
}
