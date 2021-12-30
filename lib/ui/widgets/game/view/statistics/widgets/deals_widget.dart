part of '../game_statistics_page.dart';

class _DealsWidget extends StatelessWidget {
  const _DealsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealsBuyVolume = context.read<GameStatisticsViewModel>().state.statistics.dealsBuyVolume;
    final dealsSellVolume = context.read<GameStatisticsViewModel>().state.statistics.dealsSellVolume;
    return Column(
      children: [
        _ItemWidget(
          title: S.of(context).main_game_stat_deals_count_sell,
          value: '${dealsSellVolume.length}',
        ),
        const SizedBox(height: 4),
        _ItemWidget(
          title: S.of(context).main_game_stat_deals_count_buy,
          value: '${dealsBuyVolume.length}',
        ),
        const SizedBox(height: 4),
        _ItemWidget(
          title: S.of(context).main_game_stat_deals_volume_sell,
          value: S.of(context).text_with_dollar(
                dealsSellVolume.sum.toStringAsFixed(2),
              ),
        ),
        const SizedBox(height: 4),
        _ItemWidget(
          title: S.of(context).main_game_stat_deals_volume_buy,
          value: S.of(context).text_with_dollar(
                dealsBuyVolume.sum.toStringAsFixed(2),
              ),
        ),
      ],
    );
  }
}
