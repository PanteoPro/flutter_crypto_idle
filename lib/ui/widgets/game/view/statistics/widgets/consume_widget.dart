part of '../game_statistics_page.dart';

class _ConsumeWidget extends StatelessWidget {
  const _ConsumeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buyPCs = context.read<GameStatisticsViewModel>().state.statistics.buyPCs.sum;
    final buyFlats = context.read<GameStatisticsViewModel>().state.statistics.buyFlats.sum;
    return Column(
      children: [
        _ItemWidget(title: 'Потрачено на покупки ПК', value: S.of(context).text_with_dollar(buyPCs.toStringAsFixed(2))),
        SizedBox(height: 4),
        _ItemWidget(
            title: 'Потрачено на покупки жилья', value: S.of(context).text_with_dollar(buyFlats.toStringAsFixed(2))),
        SizedBox(height: 4),
        _ConsumeEnergyWidget(),
        SizedBox(height: 4),
        _ConsumeFlatWidget(),
      ],
    );
  }
}

class _ConsumeEnergyWidget extends StatelessWidget {
  const _ConsumeEnergyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consumeEnergy = context.select((GameStatisticsViewModel vm) => vm.state.energyConsume);
    return _ItemWidget(title: 'Потрачено на электричество', value: S.of(context).text_with_dollar(consumeEnergy));
  }
}

class _ConsumeFlatWidget extends StatelessWidget {
  const _ConsumeFlatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatConsume = context.select((GameStatisticsViewModel vm) => vm.state.flatConsume);
    return _ItemWidget(title: 'Потрачено на жилье', value: S.of(context).text_with_dollar(flatConsume));
  }
}