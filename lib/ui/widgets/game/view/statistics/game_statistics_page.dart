import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/page_wrapper.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/app_images.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_statistics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

part 'widgets/consume_widget.dart';
part 'widgets/other_widget.dart';
part 'widgets/deals_widget.dart';
part 'widgets/crypto_widget.dart';

class GameStatisticsPage extends StatelessWidget {
  const GameStatisticsPage({Key? key, this.isShowBackArrow = true}) : super(key: key);

  final bool isShowBackArrow;

  @override
  Widget build(BuildContext context) {
    return PageWrapperWidget(
      isShowBackArrow: isShowBackArrow,
      child: ColoredBox(
        color: AppColors.mainGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const _TitleWidget(),
              Expanded(
                child: ListView(
                  children: [
                    _HeaderWidget(title: S.of(context).main_game_stat_consume),
                    const SizedBox(height: 6),
                    const _ConsumeWidget(),
                    const SizedBox(height: 12),
                    _HeaderWidget(title: S.of(context).main_game_stat_deals),
                    const SizedBox(height: 6),
                    const _DealsWidget(),
                    const SizedBox(height: 12),
                    _HeaderWidget(title: S.of(context).main_game_stat_other),
                    const SizedBox(height: 6),
                    const _OtherWidget(),
                    const SizedBox(height: 12),
                    _HeaderWidget(title: S.of(context).main_game_stat_crypto),
                    const SizedBox(height: 6),
                    const _CryptoWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        S.of(context).main_game_stat_title,
        style: AppFonts.main.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.main.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 6),
        const SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.lightGrey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    Key? key,
    required this.title,
    required this.value,
    this.symbol,
  }) : super(key: key);

  final String title;
  final String value;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppFonts.body.copyWith(color: AppColors.white)),
        if (symbol != null) ...[
          SizedBox(width: 4),
          Image.asset(AppImages.getTokenPathBySymbol(symbol!), width: 12, height: 12),
        ],
        Spacer(),
        Text(value, style: AppFonts.body.copyWith(color: AppColors.white)),
      ],
    );
  }
}
