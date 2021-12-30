import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class GameFooterWidget extends StatelessWidget {
  const GameFooterWidget({Key? key}) : super(key: key);

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
    final flat = context.select((GameViewModel vm) => vm.state.currentFlat);
    final locale = context.read<MainAppViewModel>().locale;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '${S.of(context).game_global_footer_place}: ',
              style: AppFonts.main.copyWith(color: AppColors.white),
              children: [
                TextSpan(
                  text: locale.languageCode == 'ru' ? flat.name : flat.nameENG,
                  style: AppFonts.main.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '${S.of(context).game_global_footer_level}: ',
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
          S.of(context).game_global_footer_consume,
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
    final maxPC = context.select((GameViewModel vm) => vm.state.maxCountPC);
    final currentPC = context.select((GameViewModel vm) => vm.state.currentCountPC);
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
    final energyConsume = context.select((GameViewModel vm) => vm.state.energyConsume);
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
    final power = context.select((GameViewModel vm) => vm.state.powerPCs);
    return Text(
      '${S.of(context).game_global_footer_power}: ${S.of(context).text_with_power_mining(power)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoIncomeWidget extends StatelessWidget {
  const _FooterOtherInfoIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final earning = context.select((GameViewModel vm) => vm.state.averageEarnings);
    return Text(
      '${S.of(context).game_global_footer_income}: ${S.of(context).text_with_dollar(earning)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoFlatWidget extends StatelessWidget {
  const _FooterOtherInfoFlatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatConsume = context.select((GameViewModel vm) => vm.state.flatConsume);
    return Text(
      '${S.of(context).game_global_footer_consume_flat}: ${S.of(context).text_with_dollar_month(flatConsume)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _FooterOtherInfoEnergyWidget extends StatelessWidget {
  const _FooterOtherInfoEnergyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final energyConsume = context.select((GameViewModel vm) => vm.state.energyConsumeCost);
    return Text(
      '${S.of(context).game_global_footer_consume_energy}: ${S.of(context).text_with_dollar_month(energyConsume)}',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}
