part of '../new_main_game_page.dart';

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: const [
              _FooterPlaceWidget(),
              _FooterMainInfoWidget(),
              SizedBox(height: 6),
              _FooterOtherInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterPlaceWidget extends StatelessWidget {
  const _FooterPlaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: TextSpan(
          text: 'Место: ',
          style: Theme.of(context).textTheme.headline1,
          children: [
            TextSpan(
              text: 'Родительский дом',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterMainInfoWidget extends StatelessWidget {
  const _FooterMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FooterMainInfoItemWidget(
          imagePath: AppImages.icon_computer,
          text: S.of(context).text_with_slash(16, 16),
        ),
        _FooterMainInfoItemWidget(
          imagePath: AppImages.icon_lightning,
          text: S.of(context).text_with_energy(9232142),
        ),
        const Spacer(),
        Text(
          'Расходы',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}

class _FooterMainInfoItemWidget extends StatelessWidget {
  const _FooterMainInfoItemWidget({
    Key? key,
    required this.imagePath,
    required this.text,
    this.width = 24,
    this.height = 24,
  }) : super(key: key);

  final String imagePath;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: width,
          height: height,
        ),
        const SizedBox(width: 2),
        Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }
}

class _FooterOtherInfoWidget extends StatelessWidget {
  const _FooterOtherInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _FooterOtherInfoPowerWidget(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            _FooterOtherInfoFlatWidget(),
            _FooterOtherInfoEnergyWidget(),
          ],
        ),
      ],
    );
  }
}

class _FooterOtherInfoPowerWidget extends StatelessWidget {
  const _FooterOtherInfoPowerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${S.of(context).main_game_info_power_mining_title}: ${S.of(context).text_with_power_mining(9432342)}',
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}

class _FooterOtherInfoFlatWidget extends StatelessWidget {
  const _FooterOtherInfoFlatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Жилье: ${S.of(context).text_with_dollar_month(0)}');
  }
}

class _FooterOtherInfoEnergyWidget extends StatelessWidget {
  const _FooterOtherInfoEnergyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Электричество: ${S.of(context).text_with_dollar_month(45000)}');
  }
}
