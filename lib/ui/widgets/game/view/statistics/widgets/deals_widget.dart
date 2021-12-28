part of '../game_statistics_page.dart';

class _DealsWidget extends StatelessWidget {
  const _DealsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemWidget(title: 'Совершено сделок на продажу', value: '34'),
        SizedBox(height: 4),
        _ItemWidget(title: 'Совершено сделок на покупку', value: '10'),
        SizedBox(height: 4),
        _ItemWidget(title: 'Объем продаж', value: '234.4\$'),
        SizedBox(height: 4),
        _ItemWidget(title: 'Объем покупок', value: '234.4\$'),
      ],
    );
  }
}
