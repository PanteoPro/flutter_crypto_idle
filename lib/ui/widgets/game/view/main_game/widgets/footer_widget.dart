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
    final flat = context.select((MainGameViewModel vm) => vm.state.flat);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Место: ',
              style: AppFonts.main.copyWith(color: AppColors.white),
              children: [
                TextSpan(
                  text: flat.name,
                  style: AppFonts.main.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Уровень: ',
              style: AppFonts.main.copyWith(color: AppColors.white),
              children: [
                TextSpan(
                  text: flat.level.toString(),
                  style: AppFonts.main.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
        ],
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
        const _FooterMainInfoPcsWidget(),
        const _FooterMainInfoEnergyWidget(),
        const Spacer(),
        Text(
          'Расходы',
          style: AppFonts.main.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

class _FooterMainInfoPcsWidget extends StatelessWidget {
  const _FooterMainInfoPcsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxPC = context.select((MainGameViewModel vm) => vm.state.flat.countPC);
    final currentPC = context.select((MainGameViewModel vm) => vm.state.myPCs.length);
    return _FooterMainInfoItemWidget(
      imagePath: AppIconsImages.computerIcon,
      text: S.of(context).text_with_slash(currentPC, maxPC),
    );
  }
}

class _FooterMainInfoEnergyWidget extends StatelessWidget {
  const _FooterMainInfoEnergyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final energyConsume = context.select((MainGameViewModel vm) => vm.state.energyConsume);
    return _FooterMainInfoItemWidget(
      imagePath: AppIconsImages.lightningIcon,
      text: S.of(context).text_with_energy(energyConsume),
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
          style: AppFonts.main.copyWith(color: AppColors.white),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FooterOtherInfoPowerWidget(),
            _FooterOtherInfoIncomeWidget(),
          ],
        ),
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
    final power = context.select((MainGameViewModel vm) => vm.state.powerPCs);
    return Text(
      '${S.of(context).main_game_info_power_mining_title}: ${S.of(context).text_with_power_mining(power)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoIncomeWidget extends StatelessWidget {
  const _FooterOtherInfoIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final earning = context.select((MainGameViewModel vm) => vm.state.averageEarnings);
    return Text(
      'Заработок за день: ${S.of(context).text_with_dollar(earning)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoFlatWidget extends StatelessWidget {
  const _FooterOtherInfoFlatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatConsume = context.select((MainGameViewModel vm) => vm.state.flatConsume);
    return Text(
      'Жилье: ${S.of(context).text_with_dollar_month(flatConsume)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoEnergyWidget extends StatelessWidget {
  const _FooterOtherInfoEnergyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final energyConsume = context.select((MainGameViewModel vm) => vm.state.energyConsumeCost);
    return Text(
      'Электричество: ${S.of(context).text_with_dollar_month(energyConsume)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}
