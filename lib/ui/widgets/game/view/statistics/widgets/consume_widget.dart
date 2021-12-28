part of '../game_statistics_page.dart';

class _ConsumeWidget extends StatelessWidget {
  const _ConsumeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemWidget(title: 'Потрачено на покупки ПК', value: '470.00\$'),
        SizedBox(height: 4),
        _ItemWidget(title: 'Потрачено на покупки жилья', value: '470.00\$'),
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
    return _ItemWidget(title: 'Потрачено на электричество', value: '470.00\$');
  }
}

class _ConsumeFlatWidget extends StatelessWidget {
  const _ConsumeFlatWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ItemWidget(title: 'Потрачено на жилье', value: '470.00\$');
  }
}
