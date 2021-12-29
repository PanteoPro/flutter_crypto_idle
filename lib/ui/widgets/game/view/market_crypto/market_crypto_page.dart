import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/buttons/game_button_widget.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'widgets/chart_widget.dart';
part 'widgets/market_widget.dart';

class MarketCryptoPage extends StatelessWidget {
  const MarketCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapperWidget(
      child: ColoredBox(
        color: AppColors.mainGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: const [
              SizedBox(height: 8),
              _TitleWidget(),
              SizedBox(height: 12),
              _PriceWidget(),
              SizedBox(height: 12),
              _ChartWidget(),
              SizedBox(height: 12),
              _CurrentBalance(),
              Spacer(),
              _MarketWidget(),
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
    final token = context.read<GameMarketCryptoViewModel>().state.token;
    return Text(
      '${S.of(context).text_with_slash(token?.symbol ?? 'NONE', 'USD')} ${token?.fullName}',
      style: AppFonts.main.copyWith(color: AppColors.white),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = context.select((GameMarketCryptoViewModel vm) => vm.state.getLastPrice());
    return SizedBox(
      width: double.infinity,
      child: Text(
        S.of(context).text_with_dollar(price.cost),
        textAlign: TextAlign.left,
        style: AppFonts.clicker.copyWith(color: AppColors.green),
      ),
    );
  }
}

class _CurrentBalance extends StatelessWidget {
  const _CurrentBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokenSymbol = context.read<GameMarketCryptoViewModel>().state.token?.symbol;
    final currentDollars = context.select((GameMarketCryptoViewModel vm) => vm.state.dollarAsset);
    final count = context.select((GameMarketCryptoViewModel vm) => vm.state.token?.count);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: '${S.of(context).game_market_crypto_available}: ',
            style: AppFonts.main.copyWith(color: AppColors.white),
            children: [
              TextSpan(
                text: '${count?.toStringAsFixed(8)} ',
                style: AppFonts.mainLight.copyWith(color: AppColors.white),
              ),
              TextSpan(
                text: tokenSymbol,
                style: AppFonts.body2.copyWith(color: AppColors.white),
              )
            ],
          ),
        ),
        Text(
          S.of(context).text_with_dollar(currentDollars.toStringAsFixed(2)),
          style: AppFonts.main.copyWith(color: AppColors.white),
        )
      ],
    );
  }
}
