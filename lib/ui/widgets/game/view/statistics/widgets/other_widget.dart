part of '../game_statistics_page.dart';

class _OtherWidget extends StatelessWidget {
  const _OtherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statistics = context.read<GameStatisticsViewModel>().state.statistics;
    return Column(
      children: [
        _ItemWidget(
          title: S.of(context).main_game_stat_other_clicker_count,
          value: statistics.clickedPC.toString(),
        ),
        const SizedBox(height: 4),
        _ItemWidget(
          title: S.of(context).main_game_stat_other_clicker_earn,
          value: S.of(context).text_with_dollar(
                statistics.clickerEarn.sum.toStringAsFixed(2),
              ),
        ),
        const SizedBox(height: 4),
        _ItemWidget(
          title: S.of(context).main_game_stat_other_clicker_crit_count,
          value: statistics.clickedPCCrits.toString(),
        ),
        const SizedBox(height: 4),
        const _OtherItemDaysWidget(),
      ],
    );
  }
}

class _OtherItemDaysWidget extends StatelessWidget {
  const _OtherItemDaysWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysCount = context.select((GameStatisticsViewModel vm) => vm.state.daysCount);
    return _ItemWidget(
      title: S.of(context).main_game_stat_other_days,
      value: daysCount,
    );
  }
}
